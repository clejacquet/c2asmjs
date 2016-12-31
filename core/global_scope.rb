require_relative('scope')

class GlobalScope < Scope
  def initialize(id_table)
    super
    @declarations = Array.new
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

  def declare(function_name, function_type, function_args_type)
    @declarations.push(name: function_name, type: function_type, args_type: function_args_type)
    new_id(function_name, nil, { return: function_type, args: function_args_type })
  end

  def declaration_code
    @declarations.reduce('') do |acc, declaration|
      args_type = declaration[:args_type].map do |arg_type|
        Type.to_llvm(arg_type)
      end.join(', ')

      acc + "declare #{Type.to_llvm(declaration[:type])} @#{declaration[:name]}(#{args_type})\n"
    end + "\n"
  end
end