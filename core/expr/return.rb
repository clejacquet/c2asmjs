class Return
  def initialize(expr = nil)
    @value = expr
  end

  def code(scope)
    scope.set_ret_done
    if not @value.nil?
      expr_type = @value.type(scope)

      begin
        expr_val = @value.try_eval
        if expr_type != scope.return_type
          expr_val = Type.convert(expr_type, scope.return_type, expr_val)
          expr_type = scope.return_type
        end
        expr_val = Type.val_to_llvm(expr_type, expr_val)
        expr_code = ''
      rescue Exception
        expr_code, expr_val = @value.code(scope)
      end

      conversion_code = ''
      if scope.return_type != expr_type
        conversion_code, expr_val = Type.build_conversion(expr_type, scope.return_type, expr_val, scope)
      end

      "#{expr_code}#{conversion_code}  ret #{Type.to_llvm(scope.return_type)} #{expr_val}\n"
    else
      'ret void'
    end
  end
end