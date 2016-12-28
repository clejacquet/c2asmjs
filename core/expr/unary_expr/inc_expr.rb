require_relative('unary_expr')

class IncExpr < UnaryExpr
  def sym
    :INC_OP
  end
end