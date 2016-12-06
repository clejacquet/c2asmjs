require_relative('language_error')

class AlreadyDefinedError < LanguageError
  def initialize(id, line_num)
    super("'#{id}' is already defined", line_num)
  end
end