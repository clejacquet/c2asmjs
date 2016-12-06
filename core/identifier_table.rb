require_relative('type_verification')
require_relative('error/already_defined_error')
require_relative('error/invalid_value_type_pair_error')
require_relative('error/identifier_not_defined_error')

class IdentifierTable
  def initialize
    @table = Hash.new
  end

  def add_id(id, type, line_num=-1)
    raise AlreadyDefinedError, id, line_num if @table.has_key? id.to_sym
    # raise InvalidValueTypePairError, value, type unless TypeVerification.is_value_of_type?(value, type)

    @table[id.to_sym] = type
  end

  def has_type(id, line_num=-1)
    raise IdentifierNotDefinedError, id.to_sym, line_num unless @table.has_key? id.to_sym

    @table[id.to_sym]
  end

=begin
  def has_value(id)
    raise IdentifierNotFoundError, id.to_sym unless @table.has_key? id.to_sym

    @table[id.to_sym][:value]
  end
=end

  def check_id(id, line_num=-1)
    raise IdentifierNotDefinedError, id.to_sym, line_num unless @table.has_key? id.to_sym
  end
end