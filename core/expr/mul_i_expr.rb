require_relative('bin_expr')

class MulIExpr < BinExpr
  protected

  def op
    'mul'
  end

  def type
    :integer
  end
end