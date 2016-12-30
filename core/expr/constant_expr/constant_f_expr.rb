require_relative('constant_expr')

class ConstantFExpr < ConstantExpr
  protected

  def op
    Type.to_llvm_op('+', inner_type)
  end

  def inner_type
    :float
  end

  def try_eval
    @val
  end
end