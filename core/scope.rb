class Scope
  def initialize(id_table)
    @id_table = id_table
  end

  def new_id(id, reg, type, size=nil)
    @id_table.add_id(id, reg, type, -1, size)
  end
end