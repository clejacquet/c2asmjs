require_relative('shift_expr')

class ShiftRightExpr < ShiftExpr
  def sym
    :SHR
  end
end