class InvalidValueTypePairError < StandardError
  def initialize(value, type)
    super("'#{value}' is not of type '#{type}'")
  end
end