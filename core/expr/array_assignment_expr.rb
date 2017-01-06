require_relative('array_element_expr')
require_relative('assignment_expr/div_assignment_expr')
require_relative('constant_expr/constant_expr')

class ArrayAssignmentExpr < ArrayElementExpr
  def initialize(array_id, index, ass_op, ass_expr, lineno)
    @ass_op = ass_op
    @ass_expr = ass_expr
    super(array_id, index, lineno)
  end

  def code(scope)
    type = scope.get_type(@array_id)
    llvm_type = Type.to_llvm(type)
    ass_expr_code, ass_expr_reg = @ass_expr.code(scope)
    ass_type = @ass_expr.type(scope)
    convert_code, convert_reg = Type.build_conversion(ass_type, type, ass_expr_reg, scope)
    element_code, element_reg = get_element_code(type, scope)
    return ass_expr_code + convert_code + element_code + "  store #{llvm_type} #{convert_reg}, #{llvm_type}* #{element_reg}\n", element_reg
  end
end