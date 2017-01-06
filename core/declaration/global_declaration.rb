class GlobalDeclaration
  def initialize(type, declarator_list, expr)
    @declarator_list = declarator_list
    @type = type
    @expr = expr
  end

  def code(gscope)
    @declarator_list.reduce('') do |acc, id|
      reg = gscope.get_reg(gscope.new_id(id, nil, @type))
      if not @expr.nil?
        acc + "#{reg} = global #{Type.to_llvm(@type)} #{Type.val_to_llvm(@type, @expr.try_eval)}\n"
      else
        acc + "#{reg} = common global #{Type.to_llvm(@type)} #{Type.val_to_llvm(@type, 0)}\n"
      end
    end
  end
end