class ArrayElementExpr
  def initialize(array_id, index)
    @array_id = array_id
    @index = index
  end

  def get_element_code(type, scope)
    llvm_type = Type.to_llvm(type)
    size = scope.get_array_size(@array_id)
    array_reg = scope.get_reg(@array_id)
    index_code, index_reg = @index.code(scope)
    index_type = @index.type(scope)

    #convert_reg = scope.new_register
    #convert_code = "#{convert_reg} = sext #{index_type} #{index_reg} to i64\n"

    convert_code, convert_reg = Type.build_conversion(index_type, :long, index_reg, scope)
    reg = scope.new_register
    return index_code + convert_code + "#{reg} = getelementptr inbounds [#{size} x #{llvm_type}], [#{size} x #{llvm_type}]* #{array_reg}, i64 0, i64 #{convert_reg}\n", reg
  end

  def code(scope)
    type = scope.get_type(@array_id)
    llvm_type = Type.to_llvm(type)
    total_code, element_reg = get_element_code(type, scope)
    load_reg = scope.new_register
    return total_code +
             "#{load_reg} = load #{llvm_type}, #{llvm_type}* #{element_reg}\n",
           load_reg
  end

  def type(scope)
    scope.get_type(@array_id)
  end
end