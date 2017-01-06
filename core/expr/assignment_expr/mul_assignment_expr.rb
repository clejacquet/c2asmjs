require_relative('assignment_expr')
require_relative('../bin_expr/mul_expr')
require_relative('../identifier_expr')

class MulAssignmentExpr < AssignmentExpr
  def initialize(id, expr, lineno)
    super(id, MulExpr.new(IdentifierExpr.new(id, lineno), expr, lineno), lineno)
  end
end