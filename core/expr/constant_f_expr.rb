require_relative('constant_expr')

class ConstantFExpr < ConstantExpr
  protected

  def op
    'fadd'
  end

  def type
    :float
  end
end