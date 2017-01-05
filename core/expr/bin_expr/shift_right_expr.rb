require_relative('shift_expr')

class ShiftRightExpr < ShiftExpr
  def sym
    :SHR
  end

  def eval_calc(val1, val2)
    val1 >> val2
  end
end