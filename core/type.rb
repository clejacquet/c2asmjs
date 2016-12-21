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
      #string:  {:llvm => '??', :policy => lambda { |value| value.respond_to? :to_s }}
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
end