require_relative('../type')
require_relative('../function_scope')
require_relative('../identifier_table')
require_relative('inner_declaration')

class Function
  attr_reader :type

  def initialize(type, decl, compound_statement)
    @type = type
    @id = decl[:id]
    @compound_statement = compound_statement

    args = decl[:args]
    if args.nil?
      @args = Array.new
    else
      @args = args
    end
  end

  def code(gscope)
    gscope.new_id(@id, nil, { return: @type, args: @args.map { |arg| arg[:type] }})
    @scope = FunctionScope.new(IdentifierTable.new, gscope, self)

    arg_regs = @args.map do |arg|
      { type: arg[:type], reg: id_to_arg_name(@scope, arg[:id]), id: arg[:id] }
    end

    arg_declarations = arg_regs.map do |arg|
      InnerDeclaration.new(arg[:type], [arg[:id]], :reg, arg).code(@scope)
    end.join

    args_str = arg_regs.map do |arg|
      "#{Type.to_llvm(arg[:type])} #{arg[:reg]}"
    end.join(', ')

    statements_code = arg_declarations + @compound_statement.code(@scope)

    return_code = (@scope.get_jump_done != :return) ? "  ret void\n" : ''
    statements_code += return_code

    "\ndefine #{Type.to_llvm(@type)} @#{@id}(#{args_str}) {\n#{statements_code}}\n"
  end

  private

  def id_to_arg_name(scope, id)
    "%a#{scope.object_id}_#{id}"
  end
end