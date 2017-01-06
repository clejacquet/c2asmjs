require_relative('type')
require_relative('scope/function_scope')
require_relative('identifier_table')
require_relative('declaration/inner_declaration')
require_relative('error/missing_return_error')

class Function
  attr_reader :type

  def initialize(type, decl, compound_statement, lineno)
    @type = type
    @id = decl[:id]
    @compound_statement = compound_statement
    @lineno = lineno

    args = decl[:args]
    if args.nil?
      @args = Array.new
    else
      @args = args
    end
  end

  def code(gscope)
    begin
      gscope.new_id(@id, nil, { return: @type, args: @args.map { |arg| arg[:type] }})
    rescue AlreadyDefinedError => msg
      ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
    end

    @scope = FunctionScope.new(IdentifierTable.new, gscope, self)

    arg_regs = @args.map do |arg|
      { type: arg[:type], reg: "%#{arg[:id]}", id: arg[:id] }
    end

    arg_declarations = arg_regs.map do |arg|
      InnerDeclaration.new(arg[:type], [arg[:id]], :reg, arg).code(@scope)
    end.join

    args_str = arg_regs.map do |arg|
      "#{Type.to_llvm(arg[:type])} #{arg[:reg]}"
    end.join(', ')

    statements_code = arg_declarations + @compound_statement.code(@scope)

    if @scope.get_jump_done != :return
      if @type == :void
        return_code = "  ret void\n"
      else
        ErrorHandler.instance.register_error(msg: MissingReturnError.new(@type, @id).message, lineno: @lineno)
        return ''
      end
    else
      return_code = ''
    end

    statements_code += return_code

    "\ndefine #{Type.to_llvm(@type)} @#{@id}(#{args_str}) {\n#{statements_code}}\n"
  end
end