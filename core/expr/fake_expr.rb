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
    raise StandardError, 'Fake expression isn\'t evaluable'
  end
end