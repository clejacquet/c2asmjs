require_relative('while_statement')

class ForStatement
  def initialize(init, cond, step, statement)
    @init = init
    @cond = cond
    @step = step
    @statement = statement
  end

  def code(scope)
    if@init
      @init.code(scope)[0] + + WhileStatement.new(@cond, @statement, @step).code(scope)
    else
      WhileStatement.new(@cond, @statement, @step).code(scope)
    end
  end
end