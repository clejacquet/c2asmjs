class Scope
  attr_reader :id_table

  def initialize(id_table)
    @id_table = id_table
    @register_count = 0
    @vars = Hash.new
  end

  def new_register
    @register_count += 1
  end

  def new_register_var(id)
    @vars[id] = id
  end

  def get_var_register(id)
    @vars[id]
  end
end