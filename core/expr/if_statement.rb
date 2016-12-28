require_relative('constant_expr/constant_i_expr')

class IfStatement
  def initialize(expr, statement)
    @expr = expr
    @statement = statement
  end

  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_val = @expr.code(scope)

    conversion_code = ''
    if expr_type != :boolean
      conversion_code, expr_val = NeExpr.new(@expr, ConstantIExpr.new(0)).code(scope)
    end

    label1_reg = scope.new_register(false)
    label1 = "\n; <label>:#{label1_reg}\n"

    scope.set_last_br("%#{label1_reg}")

    statement_code = @statement.code(scope)

    label2_reg = scope.new_register(false)
    label2 = "\n; <label>:#{label2_reg}\n"

    scope.set_last_br("%#{label2_reg}")

    br1 = "  br #{Type.to_llvm(:boolean)} #{expr_val}, label %#{label1_reg}, label %#{label2_reg}\n"
    br2 = "  br label %#{label2_reg}\n"


    expr_code + conversion_code + br1 + label1 + statement_code + br2 + label2
  end
end