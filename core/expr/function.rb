require_relative('../type')
require_relative('../inner_scope')
require_relative('../identifier_table')
require_relative('inner_declaration')

class Function
  def initialize(type, decl, statements)
    @type = type
    @id = decl[:id]
    @statements = statements

    args = decl[:args]
    if args.nil?
      @args = Array.new
    else
      @args = args
    end
  end

  def code(gscope)
    gscope.new_id(@id, { return: @type, args: @args.map { |arg| arg[:type] }})
    @scope = InnerScope.new(IdentifierTable.new, @type, gscope)

    arg_regs = @args.map do |arg|
      { type: arg[:type], reg: id_to_arg_name(@scope, arg[:id]), id: arg[:id] }
    end

    arg_declarations = arg_regs.map do |arg|
      InnerDeclaration.new(arg[:type], [arg[:id]], :reg, arg)
    end

    statements = arg_declarations.concat(@statements)

    args_str = arg_regs.map do |arg|
      "#{Type.to_llvm(arg[:type])} #{arg[:reg]}"
    end.join(', ')


    statement_code = statements.reduce('') { |acc, statement| acc + statement.code(@scope) }
    return_code = (not @scope.ret_done?) ? "ret void\n" : ''
    statement_code += return_code

    "define #{Type.to_llvm(@type)} @#{@id}(#{args_str}) {\n#{statement_code}}\n\n"
  end

  private

  def id_to_arg_name(scope, id)
    "%a#{scope.object_id}_#{id}"
  end
end