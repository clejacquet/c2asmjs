require_relative('while_statement')

class ForStatement
  def initialize(init, cond, step, statement, lineno)
    @init = init
    @cond = cond
    @step = step
    @statement = statement
    @lineno = lineno
  end

  def code(scope)
    if @init
      @init.code(scope)[0] + WhileStatement.new(@cond, @statement, @step, @lineno).code(scope)
    else
      WhileStatement.new(@cond, @statement, @step, @lineno).code(scope)
    end
  end
end