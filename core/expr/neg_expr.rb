class NegExpr
  def initialize(expr)
    @expr = expr
  end

  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_reg = @expr.code(scope)
    reg = scope.new_register

    return "#{expr_code}  #{reg} = sub #{Type.to_llvm(expr_type)} 0, #{expr_reg}\n", reg
  end

  def try_eval
    - @expr.try_eval
  end

  def type(scope)
    @expr.type(scope)
  end
end