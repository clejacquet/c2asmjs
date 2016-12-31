class Return
  def initialize(expr = nil)
    @value = expr
  end

  def code(scope)
    scope.set_jump_done(:return)

    if not @value.nil?
      expr_type = @value.type(scope)
      function_type = scope.get_function_type

      begin
        expr_val = @value.try_eval
        if expr_type != scope.get_function_type
          expr_val = Type.convert(expr_type, scope.return_type, expr_val)
          expr_type = scope.get_function_type
        end
        expr_val = Type.val_to_llvm(expr_type, expr_val)
        expr_code = ''
      rescue StandardError
        expr_code, expr_val = @value.code(scope)
      end

      conversion_code = ''
      if function_type != expr_type
        conversion_code, expr_val = Type.build_conversion(expr_type, function_type, expr_val, scope)
      end

      "#{expr_code}#{conversion_code}  ret #{Type.to_llvm(function_type)} #{expr_val}\n"
    else
      '  ret void'
    end
  end
end