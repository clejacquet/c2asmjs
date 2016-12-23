require_relative('inner_declaration')
require_relative('global_declaration')

class DeclarationBuilder
  def initialize(type, declarator_list, option = nil)
    @type = type
    @declarator_list = declarator_list
    @option = option
  end

  def build_inner
    mode, value = nil
    unless @option == nil
      mode = @option[:mode]
      value = @option[:value]
    end

    InnerDeclaration.new(@type, @declarator_list, mode, value)
  end

  def build_global
    if @option.nil?
      GlobalDeclaration.new(@type, @declarator_list)
    else
      unless @option[:mode] == :expr
        raise StandardError.new("Global declarations need an expression as initializer (not expecting #{@option[:mode]}")
      end

      GlobalDeclaration.new(@type, @declarator_list, @option[:value])
    end
  end
end