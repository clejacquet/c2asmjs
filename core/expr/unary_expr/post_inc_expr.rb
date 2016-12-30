require_relative('../identifier_expr')
require_relative('../bin_expr/add_expr')

class PostIncExpr < IdentifierExpr
  def initialize(expr)
    raise StandardError, 'expression is not assignable' unless expr.is_a? IdentifierExpr
    super(expr.id)
    @expr = expr
  end

  def code(scope)
    constant_expr = ConstantExpr.build_constant(type(scope), 1)

    expr_code, expr_val = super(scope)
    assign_code = AssignmentExpr.new(@id, AddExpr.new(@expr, constant_expr)).code(scope)[0]

    return expr_code + assign_code, expr_val
  end
end