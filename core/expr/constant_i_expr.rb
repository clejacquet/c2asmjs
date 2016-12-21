require_relative('constant_expr')

class ConstantIExpr < ConstantExpr
  protected

  def op
    'add'
  end

  def type
    :integer
  end
end