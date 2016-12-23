class AssignmentExpr
  def initialize(id, expr)
    @id = id
    @value = expr
  end

  def code(scope)
    #TODO VERIF DES TYPES
    expr_code, expr_reg, expr_type = @value.code(scope)

    reg, type = scope.get_id(@id)
    llvm_type = Type.to_llvm(type)
    return "#{expr_code}store #{llvm_type} %#{expr_reg}, #{llvm_type}* %#{reg}\n", expr_reg, expr_type
  end
end