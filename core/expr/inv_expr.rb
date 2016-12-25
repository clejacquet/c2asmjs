class InvExpr
  def initialize(expr)
    @expr = expr
  end

  def code(scope)
    expr_code, expr_reg, expr_type = @expr.code(scope)
    reg = scope.new_register

    if expr_type == :integer
      cast_op = "icmp ne i32"
    else if expr_type == :float
      cast_op = "fcmp une float"
    end

    "#{reg} = load i32, i32* #{expr_reg}\n"
    "#{reg} = icmp ne i32 #{reg}, 0\n"
    "#{reg} = xor i1 #{reg}, true\n"
    "#{reg} = zext i1 %3 to i32\n"

    #first need to cast to i1
    return "#{expr_code}#{reg} = #{cast_op} #{expr_reg} \n
           ",
        reg,
        expr_type
  end

  def try_eval
    - @expr.try_eval
  end
end