class NegExpr
  def initialize(expr)
    @expr = expr
  end

  def code(scope)
    expr_code, expr_reg, expr_type = @expr.code(scope)
    reg = scope.new_register

    return "#{expr_code}%#{reg} = sub #{Type.to_llvm(expr_type)} 0, %#{expr_reg}\n",
        reg,
        expr_type
  end
end