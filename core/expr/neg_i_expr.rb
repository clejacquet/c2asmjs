class NegIExpr
  def initialize(expr)
    @expr = expr
  end

  def code(scope)
    #TODO VERIF DES TYPES
    expr_code, expr_reg, expr_type = @expr.code(scope)
    reg = scope.new_register

    return "#{expr_code}%#{reg} = sub #{Type.to_llvm(type)} 0, %#{expr_reg}\n",
        reg,
        type
  end

  def type
    :integer
  end
end