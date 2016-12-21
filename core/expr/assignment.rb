class Assignment
  def initialize(id, expr)
    @id = id
    @expr = expr
  end

  def code(scope)
    expr_code, expr_reg = @expr.code(scope)
    llvm_type = Type.to_llvm(scope.id_table.has_type(@id))

    "#{expr_code}store #{llvm_type} %#{expr_reg}, #{llvm_type}* %#{scope.get_var_register(@id)}\n"
  end
end