require_relative('../identifier_expr')
require_relative('../fake_expr')
require_relative('../bin_expr/add_expr')
require_relative('../../error_handler')
require_relative('../../error/expression_not_assignable_error')

class PostIncExpr < IdentifierExpr
  def initialize(expr, lineno)
    if expr.is_a? IdentifierExpr
      super(expr.id, lineno)
    else
      ErrorHandler.instance.register_error(msg: ExpressionNotAssignableError.new.message, lineno: lineno)
      super(nil, lineno)
    end
    @expr = expr
  end

  def code(scope)
    if @id.nil?
      return '', ''
    end

    constant_expr = ConstantExpr.build_constant(type(scope), 1)

    expr_type = type(scope)
    expr_code, expr_val = super(scope)
    fake_expr = FakeExpr.new('', expr_val, expr_type)

    begin
      assign_code = AssignmentExpr.new(@id, AddExpr.new(fake_expr, constant_expr, @lineno), @lineno).code(scope)[0]
    rescue LanguageError => msg
      ErrorHandler.instance.register_error(msg: msg, lineno: @lineno)
      return '', ''
    end
    return expr_code + assign_code, expr_val
  end
end