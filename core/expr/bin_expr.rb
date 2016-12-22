class BinExpr
  def initialize(expr1, expr2)
    @expr1 = expr1
    @expr2 = expr2
  end

  def code(scope)
    #TODO VERIF DES TYPES
    expr1_code, expr1_reg, expr1_type = @expr1.code(scope)
    expr2_code, expr2_reg, expr2_type = @expr2.code(scope)
    reg = scope.new_register

    return "#{expr1_code}#{expr2_code}%#{reg} = #{op} #{Type.to_llvm(type)} %#{expr1_reg}, %#{expr2_reg}\n",
        reg,
        type
  end
end