require_relative('unary_expr')
require_relative('../bin_expr/ne_expr')
require_relative('../constant_expr/constant_b_expr')

class InvExpr < UnaryExpr
  def type(scope)
    :boolean
  end

  protected

  def build_code(type, op, expr_val, scope)
    ne_expr = NeExpr.new(@expr, ConstantExpr.build_constant(type(scope), 0))
    expr_code, expr_val = ne_expr.code(scope)
    code, val = super(ne_expr.type(scope), op, expr_val, scope)
    return expr_code + code, val
  end

  def sym
    '!'
  end

  def eval_calc(val)
    (val == 0) ? 1 : 0
  end

  def extra_val
    true
  end

  def first_arg?
    false
  end
end