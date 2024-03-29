require_relative('../../error/id_eval_at_compilation_error')

class AssignmentExpr
  def initialize(id, expr, lineno)
    @id = id
    @expr = expr
    @lineno = lineno
  end

  def code(scope)
    expr_type = @expr.type(scope)

    type = scope.get_type(@id)
    var = scope.get_reg(@id)
    llvm_type = Type.to_llvm(type)

    begin
      expr_val = Type.val_to_llvm(type, @expr.try_eval)
      expr_code = ''
    rescue IdEvalAtCompilationError, FakeExpressionEvalError
      begin
        expr_code, expr_val = @expr.code(scope)
        conversion_code, expr_val = Type.build_conversion(expr_type, type, expr_val, scope)
        expr_code += conversion_code
      rescue LanguageError => msg
        ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
        return '', ''
      end
    end

    return "#{expr_code}  store #{llvm_type} #{expr_val}, #{llvm_type}* #{var}\n", expr_val
  end

  def try_eval
    raise IdEvalAtCompilationError.new(@id)
  end

  def type(scope)
    begin
      @expr.type(scope)
    rescue
      :error
    end
  end
end