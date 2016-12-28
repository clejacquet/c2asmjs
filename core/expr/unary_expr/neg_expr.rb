require_relative('unary_expr')

class NegExpr < UnaryExpr
  def val(type)
    if type == :integer
      '0'
    elsif type == :float
      '0.000000e+00'
    end
  end

  def code(scope)
    expr_code, expr_reg, expr_type = @expr.code(scope)
    reg = scope.new_register

    return "#{expr_code}#{reg} = #{Type.to_llvm_op('-', expr_type)} #{Type.to_llvm(expr_type)} #{val(expr_type)}, #{expr_reg}\n",
        reg,
        expr_type
  end
end