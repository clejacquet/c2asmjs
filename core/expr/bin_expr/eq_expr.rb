require_relative('bin_expr')

class EqExpr < BinExpr
  protected

  def sym
    :EQ_OP
  end

  def eval_calc(val1, val2)
    (val1 == val2) ? 1 : 0
  end
end