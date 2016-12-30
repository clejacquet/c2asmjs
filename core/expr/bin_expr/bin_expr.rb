class BinExpr
  def initialize(expr1, expr2)
    @expr1 = expr1
    @expr2 = expr2
  end

  def code(scope)
    expr1_type = @expr1.type(scope)
    expr2_type = @expr2.type(scope)
    dominant_type = Type.dominant_type(expr1_type, expr2_type, sym)

    # OPTIMIZATION
    expr1_code, expr1_type, expr1_val = try_optimize(@expr1, expr1_type, dominant_type, scope)
    expr2_code, expr2_type, expr2_val = try_optimize(@expr2, expr2_type, dominant_type, scope)

    conversion_code = ''
    if expr1_type != expr2_type
      if dominant_type == expr2_type
        conversion_code, expr1_val = Type.build_conversion(expr1_type, expr2_type, expr1_val, scope)
      else
        conversion_code, expr2_val = Type.build_conversion(expr2_type, expr1_type, expr2_val, scope)
      end
    end

    prefix = expr1_code + expr2_code + conversion_code
    llvm_code, reg = build_code(dominant_type, op(dominant_type), expr1_val, expr2_val, scope)
    return prefix + llvm_code, reg
  end

  def try_eval
    eval_calc(@expr1.try_eval, @expr2.try_eval)
  end

  def type(scope)
    Type.output_type(Type.dominant_type(@expr1.type(scope), @expr2.type(scope), sym), sym)
  end

  protected

  def build_code(dominant_type, op, expr1_val, expr2_val, scope)
    reg = scope.new_register
    return "  #{reg} = #{op} #{Type.to_llvm(dominant_type)} #{expr1_val}, #{expr2_val}\n", reg
  end

  private

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def try_optimize(expr, expr_type, dominant_type, scope)
    begin
      expr_val = expr.try_eval
      if expr_type != dominant_type
        expr_val = Type.convert(expr_type, dominant_type, expr_val)
        expr_type = dominant_type
      end
      expr_val = Type.val_to_llvm(expr_type, expr_val)
      expr_code = ''
    rescue StandardError
      expr_code, expr_val = expr.code(scope)
    end
    return expr_code, expr_type, expr_val
  end
end