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
      reg = scope.get_name(scope.new_id(id, @type))
      acc + allocation(reg)
    end
  end

  def code_expr(scope)
    if @mode == :expr
      expr_code, expr_reg, expr_type = @value.code(scope)
    elsif @mode == :reg
      expr_code = ''
      expr_reg = @value[:reg]
      expr_type = @value[:type]
    else
      raise StandardError("Not a valid mode '#{@mode.to_s}'")
    end

    alloc_code = @declarator_list.reduce('') do |acc, id|
      reg = scope.get_name(scope.new_id(id, @type))
      conversion_code, expr_reg = Type.build_conversion(expr_type, @type, expr_reg, scope)
      acc + allocation(reg) + conversion_code + store(reg, expr_reg)
    end

    expr_code + alloc_code
  end

  def allocation(reg)
    llvm_type = Type.to_llvm(@type)
    "#{reg} = alloca #{llvm_type}\n"
  end

  def store(reg, expr_reg)
    llvm_type = Type.to_llvm(@type)
    "store #{llvm_type} #{expr_reg}, #{llvm_type}* #{reg}\n"
  end
end