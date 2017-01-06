require_relative('language_error')

class InvalidValueTypePairError < LanguageError
  def initialize(value, type)
    super("'#{value}' is not of type '#{type}'")
  end
end