require_relative('bin_expr')

class RemIExpr < BinExpr
  protected

  def op
    'srem'
  end

  def type
    :integer
  end
end