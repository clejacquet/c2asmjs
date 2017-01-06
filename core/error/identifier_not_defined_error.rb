require_relative('language_error')

class IdentifierNotDefinedError < LanguageError
  def initialize(id)
    super("Identifier '#{id}' not defined")
  end
end