require_relative('constant_expr')

class ConstantIExpr < ConstantExpr
  protected

  def op
    Type.to_llvm_op('+', inner_type)
  end

  def inner_type
    :integer
  end
end