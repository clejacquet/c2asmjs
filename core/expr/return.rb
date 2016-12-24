class Return
  def initialize(expr = nil)
    @value = expr
  end

  def code(scope)
    scope.set_ret_done
    if not @value.nil?
      expr_type = @value.type(scope)
      expr_code, expr_reg = @value.code(scope)

      conversion_code = ''
      if scope.return_type != expr_type
        conversion_code, expr_reg = Type.build_conversion(expr_type, scope.return_type, expr_reg, scope)
      end

      "#{expr_code}#{conversion_code}ret #{Type.to_llvm(scope.return_type)} #{expr_reg}\n"
    else
      'ret void'
    end
  end
end