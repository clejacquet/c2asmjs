require_relative('type')
require_relative('error/already_defined_error')
require_relative('error/invalid_value_type_pair_error')
require_relative('error/identifier_not_defined_error')

class IdentifierTable
  def initialize
    @table = Hash.new
  end

  def add_id(id, reg, type, size=nil)
    raise AlreadyDefinedError.new(id) if @table.has_key? id.to_sym

    @table[id.to_sym] = {
        type: type,
        reg: reg
    }
    if size
      @table[id.to_sym][:size] = size
    end
    id
  end

  def get_type(id)
    check_identifier_definition(id)

    @table[id.to_sym][:type]
  end

  def get_reg(id)
    check_identifier_definition(id)

    @table[id.to_sym][:reg]
  end

  def check_identifier_definition(id)
    raise IdentifierNotDefinedError.new(id.to_sym) unless @table.has_key? id.to_sym
  end

  def get_array_size(id)
    check_identifier_definition(id)

    @table[id.to_sym][:size]
  end

  def has_id?(id)
    @table.has_key? id.to_sym
  end


  def check_id(id)
    raise IdentifierNotDefinedError.new(id.to_sym) unless has_id?(id)
  end
end