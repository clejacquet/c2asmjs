require_relative('bin_expr')

class RemExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :REM
  end

  def eval_calc(val1, val2)
    val1 % val2
  end
end