class IdentifierExpr
  def initialize(id)
    @id = id
  end

  def code(scope)
    scope.id_table.check_id(@id)
    reg = scope.new_register
    type = scope.id_table.has_type(@id)
    llvm_type = Type.to_llvm(type)
    return "%#{reg} = load #{llvm_type}, #{llvm_type}* %#{scope.get_var_register(@id)}\n", reg, type
  end
end