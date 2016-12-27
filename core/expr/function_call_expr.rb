class FunctionCallExpr
  def initialize(id, args = Array.new)
    @id = id
    @args = args
  end

  def code(scope)
    type = scope.get_type(@id)
    return_type = type[:return]
    args_type = type[:args]

    arg_expr_codes = Array.new
    arg_final_exprs = Array.new

    @args.each_index do |arg_id|
      arg_type = args_type[arg_id]
      arg_expr_type = @args[arg_id].type(scope)
      arg_expr_code, arg_expr_reg = @args[arg_id].code(scope)

      arg_conversion_code, arg_expr_reg = Type.build_conversion(arg_expr_type, arg_type, arg_expr_reg, scope)

      arg_expr_codes.push(arg_expr_code + arg_conversion_code)
      arg_final_exprs.push("#{Type.to_llvm(arg_type)} #{arg_expr_reg}")
    end

    reg = scope.new_register
    expr_code = arg_expr_codes.join
    arg_code = arg_final_exprs.join(', ')
    llvm_return_type = Type.to_llvm(return_type)
    return "#{expr_code}#{reg} = call #{llvm_return_type} @#{@id}(#{arg_code})\n", reg
  end

  def try_eval
    raise StandardError('Cannot eval a function call at compilation time')
  end

  def type(scope)
    scope.get_type(@id)[:return]
  end
end