require_relative('bin_expr')

class GtExpr < BinExpr
  protected

  def op(type)
    Type.to_llvm_op(sym, type)
  end

  def sym
    '>'
  end
end