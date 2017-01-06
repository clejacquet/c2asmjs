class IdentifierExpr
  attr_reader :id

  def initialize(id, lineno)
    @id = id
    @lineno = lineno
  end

  def code(scope)
    reg = scope.new_register

    var = scope.get_reg(@id)
    llvm_type = Type.to_llvm(type(scope))
    return "  #{reg} = load #{llvm_type}, #{llvm_type}* #{var}\n", reg
  end

  def try_eval
    raise IdEvalAtCompilationError.new(@id)
  end

  def type(scope)
    begin
      scope.get_type(@id)
    rescue
      :error
    end
  end
end