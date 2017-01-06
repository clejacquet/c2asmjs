require_relative('assignment_expr')
require_relative('add_assignment_expr')
require_relative('sub_assignment_expr')
require_relative('mul_assignment_expr')
require_relative('div_assignment_expr')
require_relative('rem_assignment_expr')

class AssignmentExprFactory
  def self.build(operator, id, expr, lineno)
    case operator
      when :MUL_ASSIGN
        MulAssignmentExpr.new(id, expr, lineno)
      when :DIV_ASSIGN
        DivAssignmentExpr.new(id, expr, lineno)
      when :REM_ASSIGN
        RemAssignmentExpr.new(id, expr, lineno)
=begin
      when :SHL_ASSIGN
        ShlAssignmentExpr.new(id, expr)
      when :SHR_ASSIGN
        ShrAssignmentExpr.new(id, expr)
=end
      when :ADD_ASSIGN
        AddAssignmentExpr.new(id, expr, lineno)
      when :SUB_ASSIGN
        SubAssignmentExpr.new(id, expr, lineno)
      else
        AssignmentExpr.new(id, expr, lineno)
    end
  end
end