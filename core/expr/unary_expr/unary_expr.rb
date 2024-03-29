require_relative('../../error/language_error')

class UnaryExpr
  def initialize(expr, lineno)
    @expr = expr
    @lineno = lineno
  end

  def code(scope)
    expr_type = @expr.type(scope)

    begin
      expr_val = Type.val_to_llvm(expr_type, @expr.try_eval)
      expr_code = ''
    rescue LanguageError
      expr_code, expr_val = @expr.code(scope)
    end

    llvm_code, reg = build_code(expr_type, op(expr_type), expr_val, scope)
    return expr_code + llvm_code, reg
  end

  def type(scope)
    begin
      @expr.type(scope)
    rescue
      :error
    end
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