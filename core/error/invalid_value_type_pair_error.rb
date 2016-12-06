require_relative('language_error')

class InvalidValueTypePairError < LanguageError
  def initialize(value, type, line_num)
    super("'#{value}' is not of type '#{type}'", line_num)
  end
end