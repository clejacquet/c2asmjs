require_relative('bin_expr')

class NeExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :NE_OP
  end
end