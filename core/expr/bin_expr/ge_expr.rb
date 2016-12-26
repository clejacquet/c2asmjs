require_relative('bin_expr')

class GeExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :GE_OP
  end

  def eval_calc(val1, val2)
    (val1 >= val2) ? 1 : 0
  end
end