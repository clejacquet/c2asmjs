require_relative('language_error')
require_relative('../type')

class MissingReturnError < LanguageError
  def initialize(type, function_id)
    super("Missing return value of type #{Type.to_llvm(type)} in function '#{function_id}'")
  end
end