class AssignmentExpr
  def initialize(id, expr)
    @id = id
    @expr = expr
  end

  def code(scope)
    #TODO VERIF DES TYPES
    expr_code, expr_reg, expr_type = @expr.code(scope)
    llvm_type = Type.to_llvm(scope.id_table.has_type(@id))

    reg = scope.get_var_register(@id)
    return "#{expr_code}store #{llvm_type} %#{expr_reg}, #{llvm_type}* %#{reg}\n", expr_reg, expr_type
  end
end