class Main
  def initialize(scanner)
    @scanner = scanner
  end

  def launch
    @scanner.scope.declare('background',   :void,  [:float])
    @scanner.scope.declare('fill',         :void,  [:float])
    @scanner.scope.declare('stroke',       :void,  [:float])
    @scanner.scope.declare('point',        :void,  [:float, :float])
    @scanner.scope.declare('line',         :void,  [:float, :float, :float, :float])
    @scanner.scope.declare('ellipse',      :void,  [:float, :float, :float, :float])
    @scanner.scope.declare('rectangle',    :void,  [:float, :float, :float, :float])
    @scanner.scope.declare('sin',          :float, [:float])
    @scanner.scope.declare('cos',          :float, [:float])
    @scanner.scope.declare('log10',        :float, [:float])
    @scanner.scope.declare('createCanvas', :void,  [:float, :float])

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