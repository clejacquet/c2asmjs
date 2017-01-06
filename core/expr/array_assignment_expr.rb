require_relative('array_element_expr')
require_relative('assignment_expr/div_assignment_expr')
require_relative('constant_expr/constant_expr')

class ArrayAssignmentExpr < ArrayElementExpr
  def initialize(array_id, index, ass_op, ass_expr)
    @ass_op = ass_op
    @ass_expr = ass_expr
    super(array_id, index)
  end

  def code(scope)
    type = 'i32' # to-do
    #ass_code = AssignementExprFactory(@ass_op, @array_id, @ass_expr).code(scope)
    ass_expr_code, ass_expr_reg = @ass_expr.code(scope)
    element_code, element_reg = get_element_code(type, scope)
    return ass_expr_code + element_code + "store #{type} #{ass_expr_reg}, #{type}* #{element_reg}\n", element_reg
  end
end