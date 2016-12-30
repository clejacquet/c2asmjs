class WhileStatement
  def initialize(cond_expr, statement)
    @cond_expr = cond_expr
    @statement = statement
  end

  def code(scope)
    label1_reg = scope.new_register(false)

    scope.set_last_br("%#{label1_reg}")

    cond_expr_type = @cond_expr.type(scope)

    if cond_expr_type != :boolean
      cond_expr_code, cond_expr_val = NeExpr.new(@cond_expr, ConstantIExpr.new(0)).code(scope)
    else
      cond_expr_code, cond_expr_val = @cond_expr.code(scope)
    end

    label2_reg = scope.new_register(false)

    scope.set_last_br("%#{label2_reg}")

    statement_code = @statement.code(scope)
    if statement_code.is_a? Array
      statement_code = statement_code[0]
    end

    label3_reg = scope.new_register(false)

    scope.set_last_br("%#{label3_reg}")

    label1 = "\n; <label>:#{label1_reg}\n"
    label2 = "\n; <label>:#{label2_reg}\n"
    label3 = "\n; <label>:#{label3_reg}\n"

    br1 = "  br label %#{label1_reg}"
    br2 = "  br #{Type.to_llvm(:boolean)} #{cond_expr_val}, label %#{label2_reg}, label %#{label3_reg}"

    br1 + label1 + cond_expr_code + br2 + label2 + statement_code + br1 + label3
  end
end