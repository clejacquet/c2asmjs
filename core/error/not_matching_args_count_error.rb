require_relative('language_error')

class NotMatchingArgsCountError < LanguageError
  def initialize(provided, expected)
    super("Function call incorrect, #{provided} arg(s) provided, #{expected} arg(s) expected")
  end
end