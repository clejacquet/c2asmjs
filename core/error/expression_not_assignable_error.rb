require_relative('language_error')

class ExpressionNotAssignableError < LanguageError
  def initialize
    super('Expression different from identifier is not assignable')
  end
end