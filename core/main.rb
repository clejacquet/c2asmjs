require_relative('definition/function_definition')
require_relative('error/language_error')

class Main
  def initialize(scanner)
    @scanner = scanner
  end

  def launch
    @scanner.scope.declare_func('llvm.stacksave', :i8p, nil)
    @scanner.scope.declare_func('llvm.stackrestore', :void, [:i8p])

    @scanner.scope.declare_func('background', :void, [:float])
    @scanner.scope.declare_func('fill', :void, [:float])
    @scanner.scope.declare_func('stroke', :void, [:float])
    @scanner.scope.declare_func('point', :void, [:float, :float])
    @scanner.scope.declare_func('line', :void, [:float, :float, :float, :float])
    @scanner.scope.declare_func('ellipse', :void, [:float, :float, :float, :float])
    @scanner.scope.declare_func('rectangle', :void, [:float, :float, :float, :float])
    @scanner.scope.declare_func('sin', :float, [:float])
    @scanner.scope.declare_func('cos', :float, [:float])
    @scanner.scope.declare_func('log10', :float, [:float])
    @scanner.scope.declare_func('createCanvas', :void, [:float, :float])
    @scanner.scope.declare_func('printf', :integer, %w(i8* ...))

    @scanner.scope.declare_constant('str_int', '[7 x i8]', 'c"=> %d\0A\00"')
    @scanner.scope.declare_constant('str_double', '[8 x i8]', 'c"=> %lf\0A\00"')

    @scanner.scope.add_func_definition(FunctionDefinition.new('print_int', :void, [[:integer, 'i']], [
        'call i32 (i8*, ...) @printf(i8* getelementptr ([7 x i8], [7 x i8]* @str_int, i32 0, i32 0), i32 %i)',
        'ret void'
    ]))

    @scanner.scope.add_func_definition(FunctionDefinition.new('print_double', :void, [[:float, 'd']], [
        'call i32 (i8*, ...) @printf(i8* getelementptr ([8 x i8], [8 x i8]* @str_double, i32 0, i32 0), double %d)',
        'ret void'
    ]))

    if ARGV.size >= 1
      begin
        code = @scanner.scan_file ARGV[0]
        puts code
      rescue LanguageError => msg
        STDERR.puts msg
      end
    else
      raise 'Error, no filename provided !'
    end
  end
end