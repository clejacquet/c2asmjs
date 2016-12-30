require_relative('bin_expr')

class NeExpr < BinExpr
  protected

  def sym
    :NE_OP
  end

  def eval_calc(val1, val2)
    val1 = (val1) ? 1 : 0 if val1.is_a? FalseClass or val1.is_a? TrueClass
    val2 = (val2) ? 1 : 0 if val2.is_a? FalseClass or val2.is_a? TrueClass
    (val1 != val2) ? 1 : 0
  end
end