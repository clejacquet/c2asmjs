class UnaryExpr
  def initialize(expr)
    @expr = expr
  end

  def val(type)
    if type == :integer
      '1'
    elsif type == :float
      '1.000000e+00'
    end
  end

  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_reg = @expr.code(scope)
    reg = scope.new_register
    return "#{expr_code}#{reg} = #{Type.to_llvm_op(sym, expr_type)} #{Type.to_llvm(expr_type)} #{val(expr_type)}, #{expr_reg}\n",
        reg
  end

  def type(scope)
    @expr.type(scope)
  end

  def try_eval
    @expr.try_eval
  end
end