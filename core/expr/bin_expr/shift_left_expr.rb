require_relative('shift_expr')

class ShiftLeftExpr < ShiftExpr
  def sym
    :SHL
  end
end