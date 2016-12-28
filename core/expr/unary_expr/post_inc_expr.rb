require_relative('post_unary_expr')

class PostIncExpr < PostUnaryExpr
  def sym
    :INC_OP
  end
end