require_relative('bin_expr')

class GeExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :GE_OP
  end
end