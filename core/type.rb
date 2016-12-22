module Type
  TYPES = {
      integer: {
          llvm: 'i32',
          policy: lambda { |value| value.respond_to? :to_i },
          to_str: lambda { |value| value.to_s }
      },
      float: {
          llvm: 'double',
          policy: lambda { |value| value.respond_to? :to_f },
          to_str: lambda { |value| '%e' %value }
      },
      void: {
          llvm: 'void',
          policy: lambda { |value| raise StandardError("On void.policy: Void cannot have a value #{value}") },
          to_str: lambda { |value| raise StandardError("On void.to_str: Void cannot have a value #{value}") },
      }
      #string:  {:llvm => '??', :policy => lambda { |value| value.respond_to? :to_s }}
  }

  OPERATORS = {
      '+': {
          integer: 'add',
          float: 'fadd'
      },
      '-': {
          integer: 'sub',
          float: 'fsub'
      },
      '*': {
          integer: 'mul',
          float: 'fmul'
      },
      '/': {
          integer: 'sdiv',
          float: 'fdiv'
      },
      REM: {
          integer: 'srem',
          float: 'frem'
      },
  }

  OUTPUT_TYPES = {
      integer: {
          float: {
              default: :float
          }
      },

      float: {
          integer: {
              default: :float
          }
      }
  }

  CONVERSION_OPERATORS = {
      integer: {
          float: 'sitofp'
      },
      float: {
          integer: 'fptosi'
      }
  }

  def Type.is_value_of_type?(value, type)
    TYPES[type][:policy].call value
  end

  def Type.to_llvm(type)
    TYPES[type][:llvm]
  end

  def Type.val_to_llvm(type, val)
    TYPES[type][:to_str].call val
  end

  def Type.to_llvm_op(op, type)
    OPERATORS[op.to_sym][type]
  end

  def Type.io_conversion_types(type1, type2, op)
    output_types = OUTPUT_TYPES[type1][type2]

    if not output_types[op].nil?
      return output_types[op]
    else
      return output_types[:default]
    end
  end

  def Type.llvm_conversion_instruction(src_type, dst_type, val)
    src_type_llvm = Type.to_llvm(src_type)
    dst_type_llvm = Type.to_llvm(dst_type)
    val_llvm = (not val.to_s.start_with?('%')) ? Type.val_to_llvm(src_type, val) : val
    op = CONVERSION_OPERATORS[src_type][dst_type]

    "#{op} #{src_type_llvm} #{val_llvm} to #{dst_type_llvm}"
  end

  def Type.build_conversion(src_type, dst_type, current_reg, scope)
    if dst_type != src_type
      new_reg = scope.new_register
      return "%#{new_reg} = #{Type.llvm_conversion_instruction(src_type, dst_type, "%#{current_reg}")}\n", new_reg
    end
    return '', current_reg
  end
end