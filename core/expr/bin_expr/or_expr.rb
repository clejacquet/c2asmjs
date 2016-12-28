require_relative('bin_expr')

class OrExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :OR
  end

  def build_code(dominant_type, op, expr1_val, expr2_val, scope)
    cmp_op = Type.to_llvm_op(:NE_OP, dominant_type)

    cmp1, cmp1_reg = super(dominant_type, cmp_op, Type.val_to_llvm(dominant_type, 0), expr1_val, scope)

    label1_reg = scope.new_register(false)
    label1 = "\n; <label>:#{label1_reg}\n"

    cmp2, cmp2_reg = super(dominant_type, cmp_op, Type.val_to_llvm(dominant_type, 0), expr2_val, scope)

    label2_reg = scope.new_register(false)
    label2 = "\n; <label>:#{label2_reg}\n"

    res_reg = scope.new_register
    res = "  #{res_reg} = phi #{Type.to_llvm(type(scope))} [true, #{scope.get_last_br}], [#{cmp2_reg}, %#{label1_reg}]\n"

    br1 = "  br #{Type.to_llvm(type(scope))} #{cmp1_reg}, label %#{label2_reg}, label %#{label1_reg}\n"
    br2 = "  br label %#{label2_reg}\n"

    scope.set_last_br("%#{label2_reg}")

    llvm_code = [cmp1, br1, label1, cmp2, br2, label2, res].join
    return llvm_code, res_reg
  end

  def eval_calc(val1, val2)
    val1 or val2
  end
end