class Scope
  def initialize(id_table)
    @id_table = id_table
  end

  def new_id(id, reg, type)
    @id_table.add_id(id, reg, type)
  end
end