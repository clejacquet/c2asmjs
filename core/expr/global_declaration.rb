class GlobalDeclaration
  def initialize(type, declarator_list, expr = nil)
    @declarator_list = declarator_list
    @type = type
    @expr = expr
  end

  def code(gscope)
    @declarator_list.reduce('') do |acc, id|
      reg = gscope.get_name(gscope.new_id(id, @type))
      if not @expr.nil?
        acc + "#{reg} = global #{Type.to_llvm(@type)} #{Type.val_to_llvm(@type, @expr.try_eval)}\n\n"
      else
        acc + "#{reg} = common global #{Type.to_llvm(@type)} #{Type.val_to_llvm(@type, 0)}\n\n"
      end
    end
  end
end