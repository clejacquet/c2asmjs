class Scope
  attr_reader :id_table
  attr_reader :return_type

  def initialize(id_table, return_type)
    @id_table = id_table
    @register_count = 0
    @vars = Hash.new
    @ret_done = false
    @return_type = return_type
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

  def ret_done?
    @ret_done
  end

  def set_ret_done
    @ret_done = true
  end
end