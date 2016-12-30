require_relative('unary_expr')
require_relative('../bin_expr/ne_expr')
require_relative('../constant_expr/constant_b_expr')

class InvExpr < UnaryExpr
  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_reg = @expr.code(scope)

    code = expr_code

    ne_code, ne_reg = NeExpr.new(@expr, ConstantBExpr.new(0)).code(scope)

    #if value == 0 (or 0.0), then xor(value, true) == 1
    #if value != 0, xor(value, true) == 0
    if expr_type == :integer
      code += ne_reg
           + "#{reg} = xor i1 #{reg}, true\n"
           + "#{reg} = zext i1 %3 to i32\n"
    else
      code += "#{reg} = load float, float* #{expr_reg}\n"
           + "#{reg} = fcmp sne float #{reg}, 0.000000e+00\n"
           + "#{reg} = xor i1 #{reg}, true\n"
           + "#{reg} = zext i1 %3 to i32\n"
           + "#{reg} = sitofp i32 %4 to float" #cast back to float
    end

    return code, reg
  end
end