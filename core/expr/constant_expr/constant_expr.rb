class ConstantExpr
  def initialize(val)
    @val = val
  end

  def code(scope)
    reg = scope.new_register
    return "#{reg} = #{op} #{Type.to_llvm(type)} #{Type.val_to_llvm(type, 0)}, #{Type.val_to_llvm(type, @val)}\n",
        reg,
        type
  end

  def try_eval
    @val
  end
end