require_relative('error/unknown_conversion_error')

module Type

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
    OPERATORS_TO_LLVM[op.to_sym][type]
  end

  ##
  # Provided a +type+, returns the output type when used with +op+ operation
  def Type.output_type(type, op)
    OPERATORS_OUTPUT_TYPE[op.to_sym][type]
  end

  ##
  # Provided two types +type1+ and +type2+, returns the dominant type when used with +op+ binary operation
  def Type.dominant_type(type1, type2, op)
    output_types = DOMINATION_TYPE_LINKS[type1][type2]

    if not output_types[op.to_sym].nil?
      return output_types[op.to_sym]
    else
      return output_types[:default]
    end
  end

  ##
  # Converts +val+ from +src_type+ to +dst_type+
  def Type.convert(src_type, dst_type, val)
    if CONVERSIONS[src_type].nil? or not CONVERSIONS[src_type].include? dst_type
      raise UnknownConversionError.new(src_type, dst_type)
    end
    CONVERSION_FUNCTIONS[src_type][dst_type].call val
  end

  ##
  # Build a llvm conversion instruction to converts +val+ from +src_type+ to +dst_type+
  # +val+ can be either a constant value, or a register (starting with "%")
  def Type.llvm_conversion_instruction(src_type, dst_type, val)
    if CONVERSIONS[src_type].nil? or not CONVERSIONS[src_type].include? dst_type
      raise UnknownConversionError.new(src_type, dst_type)
    end

    src_type_llvm = Type.to_llvm(src_type)
    dst_type_llvm = Type.to_llvm(dst_type)
    val_llvm = (not val.to_s.start_with?('%')) ? Type.val_to_llvm(src_type, val) : val
    op = CONVERSION_OPERATORS[src_type][dst_type]

    "#{op} #{src_type_llvm} #{val_llvm} to #{dst_type_llvm}"
  end

  ##
  # Build a llvm conversion instruction to converts +val+ from +src_type+ to +dst_type+ and
  # returns it with the new register storing the converted value if the +src_type+ is different from the +dst_type+.
  # Otherwise, it just returns an empty instruction and the initial register (+val+)
  def Type.build_conversion(src_type, dst_type, val, scope)
    if dst_type != src_type
      new_reg = scope.new_register
      return "  #{new_reg} = #{Type.llvm_conversion_instruction(src_type, dst_type, val)}\n", new_reg
    end
    return '', val
  end

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
      boolean: {
          llvm: 'i1',
          policy: lambda { |value| value == true or value == false or
                                  (value.respond_to? :to_i and (value.to_i == 0 or value.to_i == 1)) },
          to_str: lambda { |value| (value != 0 or value == true) ? 'true' : 'false' }
      },
      long: {
        llvm: 'i64',
        policy: lambda { |value| }
      },
      i8p: {
          llvm: 'i8*'
      },
      void: {
          llvm: 'void',
          policy: lambda { |value| raise StandardError, "On void.policy: Void cannot have a value #{value}" },
          to_str: lambda { |value| raise StandardError, "On void.to_str: Void cannot have a value #{value}" },
      },
      error: {
          llvm: '',
          policy: lambda { |value| },
          to_str: lambda { |value| ''}
      }
  }

  ##
  # Operators to LLVM operation mapping.
  # For each operator, a list of its compatible types is provided with the llvm operation name corresponding.
  OPERATORS_TO_LLVM = {
      '+': {
          boolean: 'add',
          integer: 'add',
          float: 'fadd',
          error: ''
      },
      '-': {
          boolean: 'sub',
          integer: 'sub',
          float: 'fsub',
          error: ''
      },
      '*': {
          boolean: 'mul',
          integer: 'mul',
          float: 'fmul',
          error: ''
      },
      '/': {
          boolean: 'sdiv',
          integer: 'sdiv',
          float: 'fdiv',
          error: ''
      },
      REM: {
          boolean: 'srem',
          integer: 'srem',
          float: 'frem',
          error: ''
      },
      '<': {
          boolean: 'icmp slt',
          integer: 'icmp slt',
          float: 'fcmp olt',
          error: ''
      },
      '>': {
          boolean: 'icmp sgt',
          integer: 'icmp sgt',
          float: 'fcmp ogt',
          error: ''
      },
      LE_OP: {
          boolean: 'icmp sle',
          integer: 'icmp sle',
          float: 'fcmp ole',
          error: ''
      },
      GE_OP: {
          boolean: 'icmp sge',
          integer: 'icmp sge',
          float: 'fcmp oge',
          error: ''
      },
      EQ_OP: {
          boolean: 'icmp eq',
          integer: 'icmp eq',
          float: 'fcmp oeq',
          error: ''
      },
      NE_OP: {
          boolean: 'icmp ne',
          integer: 'icmp ne',
          float: 'fcmp one',
          error: ''
      },
      INC_OP: {
          boolean: 'add',
          integer: 'add',
          float: 'fadd',
          error: ''
      },
      DEC_OP: {
          boolean: 'sub',
          integer: 'sub',
          float: 'fsub',
          error: ''
      },
      AND: {
          boolean: 'icmp ne',
          integer: 'icmp ne',
          float: 'fcmp one',
          error: ''
      },
      OR: {
          boolean: 'icmp ne',
          integer: 'icmp ne',
          float: 'fcmp one',
          error: ''
      },
      '!': {
          boolean: 'xor',
          integer: 'xor',
          float: 'xor',
          error: ''
      },
      SHL: {
          integer: 'shl',
          error: ''
      },
      SHR: {
          integer: 'ashr',
          error: ''
      }
  }

  ##
  # Operation output result type
  # For each operator and each type, gives the output type of the operation given a set of value of the given type
  # It assumes that each value of this set has the given type (i.e. that the conversion has already been made)
  OPERATORS_OUTPUT_TYPE = {
      '+': {
          boolean: :boolean,
          integer: :integer,
          float: :float,
          error: :error
      },
      '-': {
          boolean: :boolean,
          integer: :integer,
          float: :float,
          error: :error
      },
      '*': {
          boolean: :boolean,
          integer: :integer,
          float: :float,
          error: :error
      },
      '/': {
          boolean: :boolean,
          integer: :integer,
          float: :float,
          error: :error
      },
      REM: {
          boolean: :boolean,
          integer: :integer,
          float: :float,
          error: :error
      },
      '<': {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      '>': {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      LE_OP: {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      GE_OP: {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      EQ_OP: {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      NE_OP: {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      AND: {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      OR: {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      '!': {
          boolean: :boolean,
          integer: :boolean,
          float: :boolean,
          error: :error
      },
      SHL: {
          integer: :integer,
          error: :error
      },
      SHR: {
          integer: :integer,
          error: :error
      }
  }

  ##
  # Provides, for a couple of types and for each operator, what is the corresponding dominant type.
  # If a provided operator is not found, :default operator is used instead.
  DOMINATION_TYPE_LINKS = {
      integer: {
          integer: {
              default: :integer
          },
          float: {
              default: :float
          },
          boolean: {
              default: :integer
          },
          error: {
              default: :error
          }
      },
      float: {
          integer: {
              default: :float
          },
          float: {
              default: :float
          },
          boolean: {
              default: :float
          },
          error: {
              default: :error
          }
      },
      boolean: {
          integer: {
              default: :integer
          },
          float: {
              default: :float
          },
          boolean: {
              default: :boolean
          },
          error: {
              default: :error
          }
      },
      error: {
          integer: {
              default: :error
          },
          float: {
              default: :error
          },
          boolean: {
              default: :error
          },
          error: {
              default: :error
          }
      }
  }

  ##
  # Authorized conversions
  CONVERSIONS = {
      integer: [
          :float,
          :boolean,
          :long,
          :error
      ],
      float: [
          :integer,
          :boolean,
          :long,
          :error
      ],
      boolean: [
          :integer,
          :float,
          :long,
          :error
      ],
      error: [
          :integer,
          :float,
          :boolean,
          :long
      ]
  }

  ##
  # Provides, for a source type and a destination type, what is the llvm conversion operation.
  CONVERSION_OPERATORS = {
      integer: {
          float: 'sitofp',
          boolean: 'zext',
          long: 'sext',
          error: ''
      },
      float: {
          integer: 'fptosi',
          boolean: 'fptosi',
          long: 'fptosi',
          error: ''
      },
      boolean: {
          integer: 'zext',
          float: 'sitofp',
          long: 'zext',
          error: ''
      },
      error: {
          integer: '',
          float: '',
          long: '',
          boolean: ''
      }
  }

  ##
  # Provides functions to convert a value from a source type to a destination type
  CONVERSION_FUNCTIONS = {
      integer: {
          float: lambda { |val| val },
          boolean: lambda { |val| (val != 0) ? 1 : 0 },
          error: lambda { |val| nil }
      },
      float: {
          integer: lambda { |val| val.floor },
          boolean: lambda { |val| (val != 0) ? 1 : 0 },
          error: lambda { |val| nil }
      },
      boolean: {
          integer: lambda { |val| val },
          float: lambda { |val| val },
          error: lambda { |val| nil }
      },
      error: {
          integer: lambda { |val| nil },
          float: lambda { |val| nil },
          boolean: lambda { |val| nil }
      }
  }
end