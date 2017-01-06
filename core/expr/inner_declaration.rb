class InnerDeclaration
  def initialize(type, declarator_list, mode = nil, value = nil)
    @declarator_list = declarator_list
    @type = type
    @mode = mode
    @value = value
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
        scope.new_id(id[:id], reg, @type, id[:size])
        acc + array_allocation("%#{reg}", id[:size]) #+ "store #{type} 0, #{type}* #{reg}\n"
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
        scope.new_id(id, reg, @type)
        conversion_code, expr_val = Type.build_conversion(expr_type, @type, expr_val, scope)
        acc + allocation("%#{reg}") + conversion_code + store("%#{reg}", expr_val)
    end

      expr_code + alloc_code
  end

  def allocation(reg)
    llvm_type = Type.to_llvm(@type)
    "  #{reg} = alloca #{llvm_type}\n"
  end

  def array_allocation(reg, size)
    llvm_type = Type.to_llvm(@type)
    "  #{reg} = alloca [#{size} x #{llvm_type}]\n"
  end

  def store(reg, expr_reg)
    llvm_type = Type.to_llvm(@type)
    "  store #{llvm_type} #{expr_reg}, #{llvm_type}* #{reg}\n"
  end
end