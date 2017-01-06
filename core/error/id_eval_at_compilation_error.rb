require_relative('language_error')

class IdEvalAtCompilationError < LanguageError
  def initialize(id, line_num = -1)
    super("Cannot eval identifier '#{id}' at compilation time", line_num)
  end
end