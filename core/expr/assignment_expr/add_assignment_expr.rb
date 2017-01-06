require_relative('assignment_expr')
require_relative('../bin_expr/add_expr')
require_relative('../identifier_expr')

class AddAssignmentExpr < AssignmentExpr
  def initialize(id, expr, lineno)
    super(id, AddExpr.new(IdentifierExpr.new(id, lineno), expr, lineno), lineno)
  end
end