class BinExpr
  def initialize(expr1, expr2)
    @expr1 = expr1
    @expr2 = expr2
  end

  def code(scope)
    expr1_code, expr1_reg, expr1_type = @expr1.code(scope)
    expr2_code, expr2_reg, expr2_type = @expr2.code(scope)

    conversion_code = ''
    type = expr1_type
    if expr1_type != expr2_type
      type = Type.output_type(expr1_type, expr2_type, sym)

      if type == expr2_type
        conversion_code, expr1_reg = Type.build_conversion(expr1_type, expr2_type, expr1_reg, scope)
      else
        conversion_code, expr2_reg = Type.build_conversion(expr2_type, expr1_type, expr2_reg, scope)
      end
    end

    reg = scope.new_register
    prefix = expr1_code + expr2_code + conversion_code
    return prefix + "#{reg} = #{op(type)} #{Type.to_llvm(type)} #{expr1_reg}, #{expr2_reg}\n", reg, type
  end

  def try_eval
    eval_calc(@expr1.try_eval, @expr2.try_eval)
  end
end