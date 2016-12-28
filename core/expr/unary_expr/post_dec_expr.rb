require_relative('post_unary_expr')

class PostDecExpr < PostUnaryExpr
  def sym
    :DEC_OP
  end
end