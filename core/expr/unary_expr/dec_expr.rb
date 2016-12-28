require_relative('unary_expr')

class DecExpr < UnaryExpr
  def sym
    :DEC_OP
  end
end