class Return
  def initialize(expr = nil)
    @expr = expr
  end

  def code(scope)
    if not @expr.nil?
      code_value, reg, type = @expr.code(scope)
      "#{code_value}ret #{Type.to_llvm(type)} %#{reg}\n"
    else
      'ret void'
    end
  end
end