require_relative('shift_expr')

class ShiftExpr < BinExpr
  def code(scope)
    l_expr_type = @expr1.type(scope)
    r_expr_type = @expr2.type(scope)

    if l_expr_type != :integer or r_expr_type != :integer
      raise StandardError.new('trying to shift non integer expressions')
    end

    l_expr_code, l_expr_type, l_expr_val = try_optimize(@expr1, :integer, :integer, scope)
    r_expr_code, r_expr_type, r_expr_val = try_optimize(@expr2, :integer, :integer, scope)


    code, reg = build_code(:integer, Type.to_llvm_op(sym, :integer), l_expr_val, r_expr_val, scope)
    return l_expr_code + r_expr_code + code, reg
  end

  def eval_calc(val1, val2)
     val1 >> val2
  end
end