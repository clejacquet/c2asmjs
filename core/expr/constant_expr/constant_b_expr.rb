require_relative('constant_expr')

class ConstantBExpr < ConstantExpr
  protected

  def op
    Type.to_llvm_op('+', inner_type)
  end

  def inner_type
    :boolean
  end

  def try_eval
    @val != 0
  end
end