require_relative('assignment_expr')
require_relative('../bin_expr/rem_expr')
require_relative('../identifier_expr')

class RemAssignmentExpr < AssignmentExpr
  def initialize(id, expr, lineno)
    super(id, RemExpr.new(IdentifierExpr.new(id, lineno), expr, lineno), lineno)
  end
end