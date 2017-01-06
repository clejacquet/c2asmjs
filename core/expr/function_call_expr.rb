require_relative('../error/id_eval_at_compilation_error')
require_relative('../error/not_matching_args_count_error')
require_relative('../error/language_error')

class FunctionCallExpr
  def initialize(id, args, lineno)
    @id = id
    @args = args
    @lineno = lineno
  end

  def code(scope)
    type = scope.get_type(@id)
    return_type = type[:return]
    args_type = type[:args]

    arg_expr_codes = Array.new
    arg_final_exprs = Array.new

    if @args.length != args_type.length
      ErrorHandler.instance.register_error(msg: NotMatchingArgsCountError.new(@args.length, args_type.length), lineno: @lineno)
      return '', ''
    end

    @args.each_index do |arg_id|
      arg_type = args_type[arg_id]
      arg_expr_type = @args[arg_id].type(scope)

      begin
        arg_expr_val = Type.val_to_llvm(arg_type, @args[arg_id].try_eval)
        arg_expr_code = ''
      rescue IdEvalAtCompilationError, FakeExpressionEvalError
        begin
          arg_expr_code, arg_expr_val = @args[arg_id].code(scope)
        rescue LanguageError => msg
          ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
          return '', ''
        end

        arg_conversion_code, arg_expr_val = Type.build_conversion(arg_expr_type, arg_type, arg_expr_val, scope)
        arg_expr_code += arg_conversion_code
      end

      arg_expr_codes.push(arg_expr_code)
      arg_final_exprs.push("#{Type.to_llvm(arg_type)} #{arg_expr_val}")
    end

    expr_code = arg_expr_codes.join
    arg_code = arg_final_exprs.join(', ')
    llvm_return_type = Type.to_llvm(return_type)

    if return_type == :void
      return "#{expr_code}  call #{llvm_return_type} @#{@id}(#{arg_code})\n", nil
    end

    reg = scope.new_register
    return "#{expr_code}  #{reg} = call #{llvm_return_type} @#{@id}(#{arg_code})\n", reg
  end

  def try_eval
    raise IdEvalAtCompilationError.new(@id)
  end

  def type(scope)
    begin
      scope.get_type(@id)[:return]
    rescue
      :error
    end
  end
end