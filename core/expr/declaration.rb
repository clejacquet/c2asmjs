class Declaration
  def initialize(type, declarator_list, lineno, expr = nil)
    @declarator_list = declarator_list
    @type = type
    @expr = expr
    @lineno = lineno
  end

  def code(scope)
    @declarator_list.each { |id| scope.id_table.add_id(id, @type, @lineno) }

    if @expr.nil?
      code_no_expr(scope)
    else
      code_expr(scope)
    end
  end

  private

  def code_no_expr(scope)
    @declarator_list.reduce('') do |acc, id|
      reg = scope.new_register_var(id)
      acc + allocation(reg)
    end
  end

  def code_expr(scope)
    expr_code, expr_reg, expr_type = @expr.code(scope)

    alloc_code = @declarator_list.reduce('') do |acc, id|
      reg = scope.new_register_var(id)
      conversion_code, expr_reg = Type.build_conversion(expr_type, @type, expr_reg, scope)
      acc + allocation(reg) + conversion_code + store(reg, expr_reg)
    end

    expr_code + alloc_code
  end

  def allocation(reg)
    llvm_type = Type.to_llvm(@type)
    "%#{reg} = alloca #{llvm_type}\n"
  end

  def store(reg, expr_reg)
    llvm_type = Type.to_llvm(@type)
    "store #{llvm_type} %#{expr_reg}, #{llvm_type}* %#{reg}\n"
  end
end