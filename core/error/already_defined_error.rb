class AlreadyDefinedError < StandardError
  def initialize(id)
    super("'#{id}' is already defined")
  end
end