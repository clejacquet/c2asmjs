class IdentifierNotDefinedError < StandardError
  def initialize(id)
    super("Identifier '#{id}' not defined")
  end
end