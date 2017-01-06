require_relative('bin_expr')
require_relative('../../error/non_integer_expr_shift_error')

class ShiftExpr < BinExpr
  def code(scope)
    l_expr_type = @expr1.type(scope)
    r_expr_type = @expr2.type(scope)

    if l_expr_type != :integer or r_expr_type != :integer
      raise NonIntegerExprShiftError
    end

    stop = false

    begin
      l_expr_code, l_expr_type, l_expr_val = try_optimize(@expr1, :integer, :integer, scope)
    rescue LanguageError => msg
      ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
      stop = true
    end

    begin
      r_expr_code, r_expr_type, r_expr_val = try_optimize(@expr2, :integer, :integer, scope)
    rescue LanguageError => msg
      ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
      stop = true
    end

    if stop
      return '', '%0'
    end

    code, reg = build_code(:integer, Type.to_llvm_op(sym, :integer), l_expr_val, r_expr_val, scope)
    return l_expr_code + r_expr_code + code, reg
  end
end