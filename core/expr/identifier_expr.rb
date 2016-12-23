class IdentifierExpr
  def initialize(id)
    @id = id
  end

  def code(scope)
    reg = scope.new_register

    type = scope.get_type(@id)
    var = scope.get_name(@id)
    llvm_type = Type.to_llvm(type)
    return "#{reg} = load #{llvm_type}, #{llvm_type}* #{var}\n", reg, type
  end

  def try_eval
    raise StandardError('Cannot eval an identifier at compilation time')
  end
end