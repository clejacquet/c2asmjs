class Scope
  def initialize(id_table)
    @id_table = id_table
  end

  def new_id(id, type)
    @id_table.add_id(id, type)
  end
end