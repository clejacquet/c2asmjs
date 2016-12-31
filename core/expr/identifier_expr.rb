class IdentifierExpr
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def code(scope)
    reg = scope.new_register

    var = scope.get_reg(@id)
    llvm_type = Type.to_llvm(type(scope))
    return "  #{reg} = load #{llvm_type}, #{llvm_type}* #{var}\n", reg
  end

  def try_eval
    raise StandardError('Cannot eval an identifier at compilation time')
  end

  def type(scope)
    scope.get_type(@id)
  end
end