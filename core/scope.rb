class Scope
  attr_reader :return_type

  def initialize(id_table, return_type, next_scope)
    @id_table = id_table
    @register_count = 0
    @ret_done = false
    @return_type = return_type
    @next_scope = next_scope
  end

  def new_register
    @register_count += 1
  end

  def new_id(id, type)
    @id_table.add_id(id, type)
  end

  def get_id(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_id(id)
      else
        raise IdentifierNotDefinedError.new(id.to_sym, -1)
      end
    else
      return var_name(id), @id_table.has_type(id)
    end
  end

  def new_function(id, return_type, args_type)
    @id_table.add_id(id, {
        return: return_type,
        args: args_type
    })
  end

  def get_function_type(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_function_type(id)
      else
        raise IdentifierNotDefinedError.new(id.to_sym, -1)
      end
    else
      type = @id_table.has_type(id)
      return type[:return], type[:args]
    end
  end

  def ret_done?
    @ret_done
  end

  def set_ret_done
    @ret_done = true
  end

  def var_name(id)
    "v#{object_id}_#{id}"
  end

  def arg_name(id)
    "a#{object_id}_#{id}"
  end
end