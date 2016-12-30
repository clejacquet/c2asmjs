require_relative('unary_expr')
require_relative('../identifier_expr')
require_relative('../assignment_expr')
require_relative('../../../core/expr/bin_expr/sub_expr')

class DecExpr < IdentifierExpr
  def initialize(expr)
    raise StandardError, 'expression is not assignable' unless expr.is_a? IdentifierExpr
    @expr = expr
    super (@expr.id)
  end

  def code(scope)
    constant_expr = ConstantExpr.build_constant(type(scope), 1)
    AssignmentExpr.new(@id, SubExpr.new(@expr, constant_expr)).code(scope)
  end
end