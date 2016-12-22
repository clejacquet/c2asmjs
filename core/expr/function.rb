require_relative('../type')
require_relative('../scope')
require_relative('../identifier_table')

class Function
  def initialize(type, decl, statements)
    @scope = Scope.new(IdentifierTable.new, type)
    @type = type
    @decl = decl
    @statements = statements
  end

  def code(scope)
    "define #{Type.to_llvm(@type)} @#{@decl} {\n#{
    @statements.reduce('') do |acc, statement|
      acc + statement.code(@scope)
    end}#{(not @scope.ret_done?) ? "ret void\n" : ''}}\n\n"
  end
end