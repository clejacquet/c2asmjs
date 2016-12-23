require_relative('bin_expr')

class DivExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    '/'
  end

  def eval_calc(val1, val2)
    val1 / val2
  end
end