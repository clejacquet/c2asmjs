require_relative('bin_expr')

class MulExpr < BinExpr
  protected

  def sym
    '*'
  end

  def eval_calc(val1, val2)
    val1 * val2
  end
end