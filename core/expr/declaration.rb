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
    llvm_type = Type.to_llvm(@type)

    @declarator_list.reduce('') do |acc, id|
      reg = scope.new_register_var(id)
      acc + "%#{reg} = alloca #{llvm_type}\n"
    end
  end

  def code_expr(scope)
    expr_code, expr_reg = @expr.code(scope)
    llvm_type = Type.to_llvm(@type)

    alloc_code = @declarator_list.reduce('') do |acc, id|
      reg = scope.new_register_var(id)
      acc + "%#{reg} = alloca #{llvm_type}\nstore #{llvm_type} %#{expr_reg}, #{llvm_type}* %#{reg}\n"
    end

    expr_code + alloc_code
  end
end