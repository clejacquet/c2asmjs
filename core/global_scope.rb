require_relative('scope')

class GlobalScope < Scope
  def get_type(id)
    unless @id_table.has_id?(id)
      raise IdentifierNotDefinedError.new(id.to_sym, -1)
    end

    @id_table.get_type(id)
  end

  def get_name(id)
    unless @id_table.has_id?(id)
      raise IdentifierNotDefinedError.new(id.to_sym, -1)
    end

    "@#{id}"
  end
end