require_relative('constant_expr')

class ConstantIExpr < ConstantExpr
  protected

  def op
    Type.to_llvm_op('+', type)
  end

  def type
    :integer
  end
end