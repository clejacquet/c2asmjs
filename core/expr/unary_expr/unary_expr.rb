class UnaryExpr
  def initialize(expr)
    @expr = expr
  end

  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_val = @expr.code(scope)

    try

    llvm_code, reg = build_code(expr_type, op(expr_type), expr_val, scope)
    return expr_code + llvm_code, reg
  end

  def type(scope)
    @expr.type(scope)
  end

  def try_eval
    eval_calc(@expr.try_eval)
  end

  protected

  def build_code(type, op, expr_val, scope)
    reg = scope.new_register

    if first_arg?
      first_arg = "#{expr_val}, #{Type.val_to_llvm(type, extra_val)}"
    else
      first_arg = "#{Type.val_to_llvm(type, extra_val)}, #{expr_val}"
    end

    return "  #{reg} = #{op} #{Type.to_llvm(type)} #{first_arg}\n", reg
  end

  private

  def op(type)
    Type.to_llvm_op(sym, type)
  end
end