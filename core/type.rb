module Type

  ##
  # Types handled.
  # "llvm" => refer to the equivalent llvm type name
  # "policy" => lambda function that checks whether a value can be interpreted as the parent type
  # "to_str" => lambda function that converts a value to a string in the llvm equivalent parent type format
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
  }

  ##
  # Operators handled.
  # For each operator, a list of its types compatible, with the llvm operation name corresponding, is provided
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
      '<': {
          integer: 'icmp slt',
          float: 'fcmp slt'
      },
      '>': {
          integer: 'icmp sgt',
          float: 'fcmp sgt'
      },
      LE_OP: {
          integer: 'icmp sle',
          float: 'fcmp sle'
      },
      GE_OP: {
          integer: 'icmp sge',
          float: 'fcmp sge'
      },
      EQ_OP: {
          integer: 'icmp eq',
          float: 'fcmp eq'
      },
      NE_OP: {
          integer: 'icmp ne',
          float: 'fcmp ne'
      }
  }

  ##
  # Provides, for a couple of types and for each operator, what is the corresponding output type.
  # If a provided operator is not found, :default operator is used instead.
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

  ##
  # Provides, for a source type and a destination type, what is the llvm conversion operation.
  CONVERSION_OPERATORS = {
      integer: {
          float: 'sitofp'
      },
      float: {
          integer: 'fptosi'
      }
  }

  ##
  # Provided a +value+ and a +type+, returns if the +value+ can be interpreted as the +type+
  def Type.is_value_of_type?(value, type)
    TYPES[type][:policy].call value
  end

  ##
  # Provided a +type+, give the corresponding llvm type name
  def Type.to_llvm(type)
    TYPES[type][:llvm]
  end

  ##
  # Provided a +value+, return its llvm format in regard of the provided +type+
  def Type.val_to_llvm(type, value)
    TYPES[type][:to_str].call value
  end

  ##
  # Provided a +op+ (operation symbol) and a +type+, returns the corresponding llvm operation name
  def Type.to_llvm_op(op, type)
    OPERATORS[op.to_sym][type]
  end

  ##
  # Provided two types +type1+ and +type2+, returns the output type when used with +op+ binary operation
  def Type.output_type(type1, type2, op)
    output_types = OUTPUT_TYPES[type1][type2]

    if not output_types[op].nil?
      return output_types[op]
    else
      return output_types[:default]
    end
  end

  ##
  # Build a llvm conversion instruction to converts +val+ from +src_type+ to +dst_type+
  # +val+ can be either a constant value, or a register (starting with "%")
  def Type.llvm_conversion_instruction(src_type, dst_type, val)
    src_type_llvm = Type.to_llvm(src_type)
    dst_type_llvm = Type.to_llvm(dst_type)
    val_llvm = (not val.to_s.start_with?('%')) ? Type.val_to_llvm(src_type, val) : val
    op = CONVERSION_OPERATORS[src_type][dst_type]

    "#{op} #{src_type_llvm} #{val_llvm} to #{dst_type_llvm}"
  end

  ##
  # Build a llvm conversion instruction to converts +current_reg+ (a register) from +src_type+ to +dst_type+ and
  # returns it with the new register storing the converted value if the +src_type+ is different from the +dst_type+.
  # Otherwise, it just returns an empty instruction and the initial register (+current_reg+)
  def Type.build_conversion(src_type, dst_type, current_reg, scope)
    if dst_type != src_type
      new_reg = scope.new_register
      return "#{new_reg} = #{Type.llvm_conversion_instruction(src_type, dst_type, current_reg)}\n", new_reg
    end
    return '', current_reg
  end
end