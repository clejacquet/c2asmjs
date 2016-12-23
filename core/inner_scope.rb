require_relative('scope')

class InnerScope < Scope
  attr_reader :return_type

  def initialize(id_table, return_type, next_scope)
    super(id_table)

    @ret_done = false
    @register_count = 0
    @return_type = return_type
    @next_scope = next_scope
  end

  def new_register
    "%#{@register_count += 1}"
  end

  def ret_done?
    @ret_done
  end

  def set_ret_done
    @ret_done = true
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

  def get_name(id)
    if not @id_table.has_id?(id)
      if not @next_scope.nil?
        return @next_scope.get_name(id)
      else
        raise IdentifierNotDefinedError.new(id.to_sym, -1)
      end
    else
      "%v#{object_id}_#{id}"
    end
  end
end