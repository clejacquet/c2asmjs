require_relative('type')
require_relative('error/already_defined_error')
require_relative('error/invalid_value_type_pair_error')
require_relative('error/identifier_not_defined_error')

class IdentifierTable
  def initialize
    @table = Hash.new
  end

  def add_id(id, reg, type, line_num=-1, size=nil)
    raise AlreadyDefinedError.new(id, line_num) if @table.has_key? id.to_sym

    @table[id.to_sym] = {
        type: type,
        reg: reg
    }
    if size
      @table[id.to_sym][:size] = size
    end
    id
  end

  def get_type(id, line_num=-1)
    check_identifier_definition(id, line_num)

    @table[id.to_sym][:type]
  end

  def get_reg(id, line_num=-1)
    check_identifier_definition(id, line_num)

    @table[id.to_sym][:reg]
  end

  def check_identifier_definition(id, line_num)
    raise IdentifierNotDefinedError.new(id.to_sym, line_num) unless @table.has_key? id.to_sym
  end

  def get_array_size(id, line_num=-1)
    check_identifier_definition(id, line_num)

    @table[id.to_sym][:size]
  end

  def has_id?(id)
    @table.has_key? id.to_sym
  end


  def check_id(id, line_num=-1)
    raise IdentifierNotDefinedError.new(id.to_sym, line_num) unless has_id?(id)
  end
end