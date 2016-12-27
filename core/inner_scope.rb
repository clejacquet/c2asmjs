require_relative('scope')

class InnerScope < Scope
  attr_reader :return_type
  attr_reader :last_br

  def initialize(id_table, return_type, next_scope)
    super(id_table)

    @ret_done = false
    @register_count = 0
    @last_br = '%0'
    @return_type = return_type
    @next_scope = next_scope
  end

  def new_register(str_mode = true)
    if str_mode
      "%#{@register_count += 1}"
    else
      @register_count += 1
    end
  end

  def ret_done?
    @ret_done
  end

  def set_ret_done
    @ret_done = true
  end

  def set_last_br(label)
    @last_br = label
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