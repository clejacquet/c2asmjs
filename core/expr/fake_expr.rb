require_relative('../error/fake_expression_eval_error')

class FakeExpr
  def initialize(code, val, type)
    @code = code
    @val = val
    @type = type
  end

  def code(scope)
    return @code, @val
  end

  def type(scope)
    @type
  end

  def try_eval
    raise FakeExpressionEvalError
  end
end