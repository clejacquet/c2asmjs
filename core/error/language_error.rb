class LanguageError < StandardError
  def initialize(message, line_num)
    if line_num != -1
      super("Error at line #{line_num}: \n#{message}")
    else
      super(message)
    end
  end
end