require_relative('unary_expr')

class PostUnaryExpr < UnaryExpr
  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_reg = @expr.code(scope)
    reg = scope.new_register
    return "#{expr_code}#{reg} = #{Type.to_llvm_op(sym, expr_type)} #{Type.to_llvm(expr_type)} #{val(expr_type)}, #{expr_reg}\n",
        reg,
        expr_type
  end

  def try_eval
    @expr.try_eval
  end
end