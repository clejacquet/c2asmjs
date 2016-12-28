require_relative('unary_expr')

class InvExpr < UnaryExpr
  def code(scope)
    expr_code, expr_reg, expr_type = @expr.code(scope)
    reg = scope.new_register

    code = expr_code

    #if value == 0 (or 0.0), then xor(value, true) == 1
    #if value != 0, xor(value, true) == 0
    if expr_type == :integer
      code += "#{reg} = load i32, i32* #{expr_reg}\n"
           + "#{reg} = icmp ne i32 #{reg}, 0\n"
           + "#{reg} = xor i1 #{reg}, true\n"
           + "#{reg} = zext i1 %3 to i32\n"
    else
      code += "#{reg} = load float, float* #{expr_reg}\n"
           + "#{reg} = fcmp sne float #{reg}, 0.000000e+00\n"
           + "#{reg} = xor i1 #{reg}, true\n"
           + "#{reg} = zext i1 %3 to i32\n"
           + "#{reg} = sitofp i32 %4 to float" #cast back to float
    end

    return code,
        reg,
        expr_type
  end
end