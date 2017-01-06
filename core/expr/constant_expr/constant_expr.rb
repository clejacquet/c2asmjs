require_relative('../fake_expr')

class ConstantExpr
  def initialize(val)
    @val = val
  end

  def code(scope)
    reg = scope.new_register
    llvm_type = Type.to_llvm(inner_type)
    initializer = Type.val_to_llvm(inner_type, 0)
    llvm_val = Type.val_to_llvm(inner_type, @val)

    return "  #{reg} = #{op} #{llvm_type} #{initializer}, #{llvm_val}\n", reg
  end

  def type(scope)
    inner_type
  end

  def self.build_constant(type, val)
    case type
      when :boolean
        ConstantBExpr.new(val)
      when :integer
        ConstantIExpr.new(val)
      when :float
        ConstantFExpr.new(val)
      else
        FakeExpr.new('', '', :error)
    end
  end
end