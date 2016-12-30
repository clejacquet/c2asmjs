require_relative('constant_expr')

class ConstantFExpr < ConstantExpr
  def try_eval
    @val
  end

  protected

  def op
    Type.to_llvm_op('+', inner_type)
  end

  def inner_type
    :float
  end
end