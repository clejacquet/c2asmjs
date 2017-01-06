require_relative('unary_expr')
require_relative('../../error_handler')
require_relative('../identifier_expr')
require_relative('../assignment_expr/add_assignment_expr')
require_relative('../bin_expr/add_expr')
require_relative('../../error/expression_not_assignable_error')

class IncExpr < IdentifierExpr
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
    constant_expr = ConstantExpr.build_constant(type(scope), 1)

    if @id.nil?
      AddExpr.new(@expr, constant_expr, @lineno).code(scope)
      return '', ''
    end

    begin
      AssignmentExpr.new(@id, AddExpr.new(@expr, constant_expr, @lineno), @lineno).code(scope)
    rescue LanguageError => msg
      ErrorHandler.instance.register_error(msg)
      return '', ''
    end
  end
end