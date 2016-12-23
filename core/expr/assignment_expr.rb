class AssignmentExpr
  def initialize(id, expr)
    @id = id
    @expr = expr
  end

  def code(scope)
    expr_code, expr_reg, expr_type = @expr.code(scope)

    type = scope.get_type(@id)
    var = scope.get_name(@id)
    llvm_type = Type.to_llvm(type)

    conversion_code, expr_reg = Type.build_conversion(expr_type, type, expr_reg, scope)

    return "#{expr_code}#{conversion_code}store #{llvm_type} #{expr_reg}, #{llvm_type}* #{var}\n", expr_reg, expr_type
  end

  def try_eval
    raise StandardError('Cannot eval assignment at compilation time')
  end
end