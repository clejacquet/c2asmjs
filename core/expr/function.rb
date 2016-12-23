require_relative('../type')
require_relative('../scope')
require_relative('../identifier_table')
require_relative('declaration')

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

  def code(scope)
    scope.new_function(@id, @type, @args.map { |arg| arg[:type] })
    @scope = Scope.new(IdentifierTable.new, @type, scope)

    arg_regs = @args.map do |arg|
      { type: arg[:type], reg: @scope.arg_name(arg[:id]), id: arg[:id] }
    end

    arg_declarations = arg_regs.map do |arg|
      Declaration.new(arg[:type], [arg[:id]], :reg, arg)
    end

    statements = arg_declarations.concat(@statements)

    args_str = arg_regs.map do |arg|
      "#{Type.to_llvm(arg[:type])} %#{arg[:reg]}"
    end.join(', ')


    statement_code = statements.reduce('') { |acc, statement| acc + statement.code(@scope) }
    return_code = (not @scope.ret_done?) ? "ret void\n" : ''
    statement_code += return_code

    "define #{Type.to_llvm(@type)} @#{@id}(#{args_str}) {\n#{statement_code}}\n\n"
  end
end