require_relative('assignment_expr')
require_relative('../bin_expr/div_expr')
require_relative('../identifier_expr')

class DivAssignmentExpr < AssignmentExpr
  def initialize(id, expr)
    super(id, DivExpr.new(IdentifierExpr.new(id), expr))
  end
end