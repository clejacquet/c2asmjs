require_relative('../identifier_expr')
require_relative('../fake_expr')
require_relative('../bin_expr/sub_expr')

class PostDecExpr < IdentifierExpr
  def initialize(expr)
    raise StandardError, 'expression is not assignable' unless expr.is_a? IdentifierExpr
    super(expr.id)
    @expr = expr
  end

  def code(scope)
    constant_expr = ConstantExpr.build_constant(type(scope), 1)

    expr_type = type(scope)
    expr_code, expr_val = super(scope)
    fake_expr = FakeExpr.new('', expr_val, expr_type)

    assign_code = AssignmentExpr.new(@id, SubExpr.new(fake_expr, constant_expr)).code(scope)[0]

    return expr_code + assign_code, expr_val
  end
end