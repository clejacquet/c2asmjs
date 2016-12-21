require_relative('bin_expr')

class AddIExpr < BinExpr
  protected

  def op
    'add'
  end

  def type
    :integer
  end
end