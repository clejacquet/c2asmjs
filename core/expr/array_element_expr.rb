class ArrayElementExpr
  def initialize(array_id, index)
    @array_id = array_id
    @index = index
  end

  def get_element_code(reg, type, scope)
    size = scope.get_array_size(@array_id)
    array_reg = scope.get_reg(@array_id)
    "#{reg} = getelementptr inbounds [#{size} x #{type}], [#{size} x #{type}]* #{array_reg}, i64 0, i64 #{@index}\n"
  end

  def code(scope)
    element_reg = scope.new_register
    type = "i32" # to-do
    load_reg = scope.new_register
    return get_element_code(element_reg, type, scope) +
             "#{load_reg} = load #{type}, #{type}* #{element_reg}\n",
           load_reg
  end

  def type(scope)
    scope.get_type(@array_id)
  end
end