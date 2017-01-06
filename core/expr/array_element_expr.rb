class ArrayElementExpr
  def initialize(array_id, index)
    @array_id = array_id
    @index = index
  end

  def get_element_code(type, scope)
    size = scope.get_array_size(@array_id)
    array_reg = scope.get_reg(@array_id)
    index_code, index_reg = @index.code(scope)
    index_type = Type.to_llvm(@index.type(scope))
    convert_reg = scope.new_register
    convert_code = "#{convert_reg} = sext #{index_type} #{index_reg} to i64\n"
    reg = scope.new_register
    return index_code + convert_code + "#{reg} = getelementptr inbounds [#{size} x #{type}], [#{size} x #{type}]* #{array_reg}, i64 0, i64 #{convert_reg}\n", reg
  end

  def code(scope)

    type = 'i32' # to-do
    total_code, element_reg = get_element_code(type, scope)
    load_reg = scope.new_register
    return total_code +
             "#{load_reg} = load #{type}, #{type}* #{element_reg}\n",
           load_reg
  end

  def type(scope)
    scope.get_type(@array_id)
  end
end