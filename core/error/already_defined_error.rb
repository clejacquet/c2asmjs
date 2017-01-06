require_relative('language_error')

class AlreadyDefinedError < LanguageError
  def initialize(id)
    super("'#{id}' is already defined")
  end
end