require_relative('bin_expr')

class SubIExpr < BinExpr
  protected

  def op
    'sub'
  end

  def type
    :integer
  end
end