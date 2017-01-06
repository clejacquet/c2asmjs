class InnerDeclaration
  def initialize(type, declarator_list, mode, value, lineno)
    @declarator_list = declarator_list
    @type = type
    @mode = mode
    @value = value
    @lineno = lineno
  end

  def code(scope)
    if @mode.nil?
      code_no_expr(scope)
    else
      code_expr(scope)
    end
  end

  private

  def code_no_expr(scope)
    @declarator_list.reduce('') do |acc, id|
      reg = scope.new_register(false)
      if id.is_a? Hash
        acc + array_allocation(id[:id], "%#{reg}", id[:size], scope) #+ "store #{type} 0, #{type}* #{reg}\n"
      else
        scope.new_id(id, reg, @type)
        acc + allocation("%#{reg}")
      end
    end
  end

  def code_expr(scope)
    if @mode == :expr
      expr_type = @value.type(scope)

      # OPTIMIZATION
      begin
        expr_val = Type.val_to_llvm(expr_type, @value.try_eval)
        expr_code = ''
      rescue StandardError
        expr_code, expr_val = @value.code(scope)
      end
    elsif @mode == :reg
      expr_code = ''
      expr_val = @value[:reg]
      expr_type = @value[:type]
    else
      raise StandardError, "Not a valid mode '#{@mode.to_s}'"
    end

    alloc_code = @declarator_list.reduce('') do |acc, id|
      reg = scope.new_register(false)
        begin
          scope.new_id(id, reg, @type)
          conversion_code, expr_val = Type.build_conversion(expr_type, @type, expr_val, scope)
          acc + allocation("%#{reg}") + conversion_code + store("%#{reg}", expr_val)
        rescue LanguageError => msg
          ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
          acc
        end
    end

      expr_code + alloc_code
  end

  def allocation(reg)
    llvm_type = Type.to_llvm(@type)
    "  #{reg} = alloca #{llvm_type}\n"
  end

  def array_allocation(id, reg, size, scope)
    llvm_type = Type.to_llvm(@type)

    size_code, size_reg = size.code(scope)
    size_type = size.type(scope)

    convert_code, convert_reg = Type.build_conversion(size_type, :long, size_reg, scope)
    stack_reg = scope.new_register

    array_reg = scope.new_register(false)
    scope.new_id(id, array_reg, @type, size_reg)

    "  #{reg} = alloca i8*\n" + size_code + convert_code +
        "  store i8* #{stack_reg}, i8** #{reg}\n" +
        "  #{stack_reg} = call i8* @llvm.stacksave()\n" +
        "  %#{array_reg} = alloca #{llvm_type}, i64 #{convert_reg}\n"
  end

  def store(reg, expr_reg)
    llvm_type = Type.to_llvm(@type)
    "  store #{llvm_type} #{expr_reg}, #{llvm_type}* #{reg}\n"
  end
end