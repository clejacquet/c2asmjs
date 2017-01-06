require_relative('assignment_expr')
require_relative('../bin_expr/sub_expr')
require_relative('../identifier_expr')

class SubAssignmentExpr < AssignmentExpr
  def initialize(id, expr, lineno)
    super(id, SubExpr.new(IdentifierExpr.new(id, lineno), expr, lineno), lineno)
  end
end