require_relative('scope')

class InnerScope < Scope
  def initialize(id_table, next_scope)
    super(id_table)

    @register_count = 0
    @last_br = '%0'
    @next_scope = next_scope
    @function_scope = next_scope.get_function_scope
  end

  def new_register(str_mode = true)
    @function_scope.new_register(str_mode)
  end

  def get_last_br
    @function_scope.get_last_br
  end

  def set_last_br(label)
    @function_scope.set_last_br(label)
  end

  def get_function_type
    @function_scope.get_function_type
  end

  def get_jump_done
    @function_scope.get_jump_done
  end

  def set_jump_done(jump)
    @function_scope.set_jump_done(jump)
  end

  def get_function_scope
    @function_scope
  end

  def get_type(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_type(id)
      else
        raise IdentifierNotDefinedError.new(id.to_sym, -1)
      end
    else
      @id_table.get_type(id)
    end
  end

  def get_reg(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_reg(id)
      else
        raise IdentifierNotDefinedError.new(id.to_sym, -1)
      end
    else
      "%#{@id_table.get_reg(id)}"
    end
  end

  def get_array_size(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_array_size(id)
      else
        raise IdentifierNotDefinedError.new(id.to_sym, -1)
      end
    else
      @id_table.get_array_size(id)
    end
  end
end