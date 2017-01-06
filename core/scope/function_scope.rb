require_relative('scope')
require_relative('../error_handler')

class FunctionScope < Scope
  def initialize(id_table, next_scope, function_handler)
    super(id_table)

    @register_count = 0
    @last_br = '%0'
    @next_scope = next_scope
    @function_handler = function_handler
  end

  def new_register(str_mode = true)
    if str_mode
      "%#{@register_count += 1}"
    else
      @register_count += 1
    end
  end

  def get_last_br
    @last_br
  end

  def set_last_br(label)
    @last_br = label
  end

  def get_function_type
    @function_handler.type
  end

  def get_jump_done
    @jump_done
  end

  def set_jump_done(jump)
    @jump_done = jump
  end

  def get_function_scope
    self
  end

  def get_type(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_type(id)
      else
        ErrorHandler.instance.register_error(IdentifierNotDefinedError.new(id.to_sym))
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
        ErrorHandler.instance.register_error(IdentifierNotDefinedError.new(id.to_sym))
      end
    else
      "%#{@id_table.get_reg(id)}"
    end
  end
end