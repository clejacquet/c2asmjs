require_relative('language_error')

class FakeExpressionEvalError < LanguageError
  def initialize
    super('Fake expression isn\'t evaluable', -1)
  end
end