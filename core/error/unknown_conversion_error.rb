require_relative('language_error')

class UnknownConversionError < LanguageError
  def initialize(type_src, type_dst)
    super("Can't convert type '#{type_src}' to type '#{type_dst}': unknown conversion")
  end
end