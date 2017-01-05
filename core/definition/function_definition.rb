class FunctionDefinition
  def initialize(id, type, args, statements)
    @id = id
    @type = type
    @args = args
    @statements = statements.map { |statement| '  ' + statement }
  end

  def code(gscope)
    type = Type.to_llvm(@type)
    gscope.new_id(@id, nil, { return: @type, args: @args.map { |arg| arg[0] }})
    "\ndefine #{type} @#{@id}(#{@args.map { |arg| "#{Type.to_llvm(arg[0])} %#{arg[1]}" }.join(', ')}) {\n" +
        "#{@statements.join("\n")}\n" +
    "}\n"
  end
end