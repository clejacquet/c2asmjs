require_relative('unary_expr')
require_relative('../identifier_expr')
require_relative('../assignment_expr')
require_relative('../../../core/expr/bin_expr/add_expr')

class IncExpr < UnaryExpr
  def initialize(expr)
    raise StandardError, 'expression is not assignable' unless expr.is_a? IdentifierExpr
    super(expr)
    @id = expr.id
  end

  def try_eval
    raise StandardError('Cannot eval an identifier at compilation time')
  end

  def code(scope)
    constant_expr = ConstantExpr.build_constant(type(scope), 1)
    AssignmentExpr.new(@id, AddExpr.new(@expr, constant_expr)).code(scope)
  end

  protected

  def sym
    :INC_OP
  end

  def extra_val
    1
  end

  def first_arg?
    false
  end
end