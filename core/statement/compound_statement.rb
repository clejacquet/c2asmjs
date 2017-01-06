require_relative('../scope/inner_scope')

class CompoundStatement
  def initialize(statements)
    @compound_statement = statements
  end

  def code(scope)
    inner_scope = InnerScope.new(IdentifierTable.new, scope)

    @compound_statement.reduce('') do |acc, statement|
      if statement
        statement_code = statement.code(inner_scope)

        if statement_code.is_a? Array
          statement_code = statement_code[0]
        end
        acc + statement_code
      end
    end
  end
end