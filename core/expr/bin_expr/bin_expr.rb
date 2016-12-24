class BinExpr
  def initialize(expr1, expr2)
    @expr1 = expr1
    @expr2 = expr2
  end

  def code(scope)
    expr1_type = @expr1.type(scope)
    expr2_type = @expr2.type(scope)

    # OPTIMIZATION
    begin
      expr1_val = Type.val_to_llvm(expr1_type, @expr1.try_eval)
      expr2_val = Type.val_to_llvm(expr2_type, @expr2.try_eval)

      expr1_code = expr2_code = ''
    rescue Exception
      expr1_code, expr1_val = @expr1.code(scope)
      expr2_code, expr2_val = @expr2.code(scope)
    end

    conversion_code = ''
    dominant_type = Type.dominant_type(expr1_type, expr2_type, sym)
    if expr1_type != expr2_type
      if dominant_type == expr2_type
        conversion_code, expr1_val = Type.build_conversion(expr1_type, expr2_type, expr1_val, scope)
      else
        conversion_code, expr2_val = Type.build_conversion(expr2_type, expr1_type, expr2_val, scope)
      end
    end

    output_type = Type.output_type(dominant_type, sym)

    reg = scope.new_register
    prefix = expr1_code + expr2_code + conversion_code
    return prefix + "#{reg} = #{op(output_type)} #{Type.to_llvm(dominant_type)} #{expr1_val}, #{expr2_val}\n", reg
  end

  def try_eval
    eval_calc(@expr1.try_eval, @expr2.try_eval)
  end

  def type(scope)
    Type.output_type(Type.dominant_type(@expr1.type(scope), @expr2.type(scope), sym), sym)
  end
end