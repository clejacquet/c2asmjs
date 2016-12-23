class IdentifierExpr
  def initialize(id)
    @id = id
  end

  def code(scope)
    reg = scope.new_register
    var, type = scope.get_id(@id)
    llvm_type = Type.to_llvm(type)
    return "%#{reg} = load #{llvm_type}, #{llvm_type}* %#{var}\n", reg, type
  end
end