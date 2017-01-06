require_relative('language_error')

class NonIntegerExprShiftError < LanguageError
  def initialize(line_num = -1)
    super('Trying to shift non integer expressions', line_num)
  end
end