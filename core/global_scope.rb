require_relative('scope')

class GlobalScope < Scope
  def initialize(id_table)
    super
    @function_definitions = Array.new
    @function_declarations = Array.new
    @constants = Array.new
  end

  def get_type(id)
    unless @id_table.has_id?(id)
      raise IdentifierNotDefinedError.new(id.to_sym, -1)
    end

    @id_table.get_type(id)
  end

  def get_reg(id)
    unless @id_table.has_id?(id)
      raise IdentifierNotDefinedError.new(id.to_sym, -1)
    end

    "@#{id}"
  end

  def add_func_definition(func_definition)
    @function_definitions.push(func_definition)
  end

  def declare_func(function_name, function_type, function_args_type)
    @function_declarations.push(name: function_name, type: function_type, args_type: function_args_type)
    new_id(function_name, nil, { return: function_type, args: function_args_type })
  end

  def declare_constant(id, type, value)
    @constants.push(id: id, type: type, value: value)
    new_id(id, nil, type)
  end

  def declaration_code
    constants_code = @constants.reduce('') do |acc, constant|
      acc + "@#{constant[:id]} = constant #{constant[:type]} #{constant[:value]}\n"
    end + "\n"

    functions_code = @function_declarations.reduce('') do |acc, declaration|
      if declaration[:args_type]
        args_type = declaration[:args_type].map do |arg_type|
          if arg_type.is_a? Symbol
            Type.to_llvm(arg_type)
          else
            arg_type.to_s
          end
        end.join(', ')
      end

      if declaration[:type].is_a? Symbol
        type = Type.to_llvm(declaration[:type])
      else
        type = declaration[:type].to_s
      end
      acc + "declare #{type} @#{declaration[:name]}(#{args_type})\n"
    end + "\n" + @function_definitions.map { |func_def| func_def.code(self) }.join('') + "\n"

    constants_code + functions_code
  end
end