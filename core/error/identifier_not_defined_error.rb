require_relative('language_error')

class IdentifierNotDefinedError < LanguageError
  def initialize(id, line_num)
    super("Identifier '#{id}' not defined", line_num)
  end
end