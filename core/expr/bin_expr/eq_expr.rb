require_relative('bin_expr')

class EqExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :EQ_OP
  end
end