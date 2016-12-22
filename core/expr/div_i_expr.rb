require_relative('bin_expr')

class DivIExpr < BinExpr
  protected

  def op
    'sdiv'
  end

  def type
    :integer
  end
end