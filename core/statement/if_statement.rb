require_relative('../../core/expr/constant_expr/constant_i_expr')

class IfStatement
  def initialize(expr, statement, else_statement = nil)
    @expr = expr
    @statement = statement
    @else_statement = else_statement
  end

  def code(scope)
    expr_type = @expr.type(scope)

    begin
      expr_val = @expr.try_eval

      if expr_val != 0
        code_only_if(scope)
      else
        code_only_else(scope)
      end
    rescue StandardError
      if expr_type != :boolean
        expr_code, expr_val = NeExpr.new(@expr, ConstantIExpr.new(0)).code(scope)
      else
        expr_code, expr_val = @expr.code(scope)
      end
      code_not_evaluated(expr_code, expr_val, scope)
    end
  end

  private

  def code_only_if(scope)
    statement_code = @statement.code(scope)
    if statement_code.is_a? Array
      statement_code = statement_code[0]
    end
    statement_code
  end

  def code_only_else(scope)
    if @else_statement.nil?
      return ''
    end

    statement_code = @else_statement.code(scope)
    if statement_code.is_a? Array
      statement_code = statement_code[0]
    end
    statement_code
  end

  def code_not_evaluated(expr_code, expr_val, scope)
    label1_reg = scope.new_register(false)
    label1 = "\n; <label>:#{label1_reg}\n"

    scope.set_last_br("%#{label1_reg}")

    statement_code = @statement.code(scope)
    if statement_code.is_a? Array
      statement_code = statement_code[0]
    end

    label2_reg = scope.new_register(false)
    label2 = "\n; <label>:#{label2_reg}\n"

    scope.set_last_br("%#{label2_reg}")

    br1 = "  br #{Type.to_llvm(:boolean)} #{expr_val}, label %#{label1_reg}, label %#{label2_reg}\n"
    br2 = "  br label %#{label2_reg}\n"

    else_code = ''
    unless @else_statement.nil?
      else_statement_code = @else_statement.code(scope)

      label3_reg = scope.new_register(false)
      label3 = "\n; <label>:#{label3_reg}\n"

      scope.set_last_br("%#{label3_reg}")

      br2 = "  br label %#{label3_reg}\n"
      br3 = "  br label %#{label3_reg}\n"

      else_code = else_statement_code + br3 + label3
    end

    expr_code + br1 + label1 + statement_code + br2 + label2 + else_code
  end
end