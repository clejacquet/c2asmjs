class CustomExpr
  def initialize(code, val, type)
    @code = code
    @val = val
    @type = type
  end

  def code(scope)
    return @code, @val
  end

  def try_eval
    raise StandardError, 'Cannot eval a custom expr'
  end

  def type(scope)
    @type
  end
end