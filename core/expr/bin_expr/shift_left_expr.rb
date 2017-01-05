require_relative('shift_expr')

class ShiftLeftExpr < ShiftExpr
  def sym
    :SHL
  end

  def eval_calc(val1, val2)
    val1 << val2
  end
end