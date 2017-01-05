class Main
  def initialize(scanner)
    @scanner = scanner
  end

  def launch
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
    @scanner.scope.declare_func('print', :integer, %w(i8* ...))

    @scanner.scope.declare_constant('str_int', '[7 x i8]', 'c"=> %d\0A\00"')
    @scanner.scope.declare_constant('str_double', '[8 x i8]', 'c"=> %lf\0A\00"')

    if ARGV.size >= 1
      begin
        code = @scanner.scan_file ARGV[0]
        puts code
      rescue AlreadyDefinedError => msg
        STDERR.puts msg
      rescue IdentifierNotDefinedError => msg
        STDERR.puts msg
      rescue StandardError => msg
        STDERR.puts msg
      end
    else
      raise 'Error, no filename provided !'
    end
  end
end