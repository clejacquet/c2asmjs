require_relative('bin_expr')

class LtExpr < BinExpr
  protected

  def sym
    '<'
  end

  def eval_calc(val1, val2)
    (val1 < val2) ? 1 : 0
  end
end