require_relative('language_error')

class IdEvalAtCompilationError < LanguageError
  def initialize(id)
    super("Cannot eval identifier '#{id}' at compilation time")
  end
end