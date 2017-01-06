require_relative('language_error')

class NonIntegerExprShiftError < LanguageError
  def initialize
    super('Trying to shift non integer expressions')
  end
end