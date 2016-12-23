require_relative('bin_expr')

class LeExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    :LE_OP
  end
end