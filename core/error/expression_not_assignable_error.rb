require_relative('language_error')

class ExpressionNotAssignableError < LanguageError
  def initialize(line_num = -1)
    super('Expression different from identifier is not assignable', line_num)
  end
end