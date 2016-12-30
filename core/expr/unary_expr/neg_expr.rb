require_relative('unary_expr')

class NegExpr < UnaryExpr
  protected

  def sym
    '-'
  end

  def eval_calc(val)
    - val
  end

  def extra_val
    0
  end

  def first_arg?
    false
  end
end