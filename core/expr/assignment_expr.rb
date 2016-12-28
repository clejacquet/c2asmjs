class AssignmentExpr
  def initialize(id, expr)
    @id = id
    @expr = expr
  end

  def code(scope)
    expr_type = @expr.type(scope)
    expr_code, expr_val = @expr.code(scope)

    type = scope.get_type(@id)
    var = scope.get_name(@id)
    llvm_type = Type.to_llvm(type)

    conversion_code, expr_val = Type.build_conversion(expr_type, type, expr_val, scope)

    return "#{expr_code}#{conversion_code}  store #{llvm_type} #{expr_val}, #{llvm_type}* #{var}\n", expr_val
  end

  def try_eval
    raise StandardError('Cannot eval assignment at compilation time')
  end

  def type(scope)
    @expr.type(scope)
  end
end