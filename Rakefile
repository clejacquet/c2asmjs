task default: :build

task :build do
  sh 'mkdir -p build'
  sh 'rex scanner.rex -o build/scanner.rex.rb'
  sh 'racc grammar.racc -o build/grammar.racc.rb'
end

task :run, [:file] => [:build] do |t, args|
  ruby "build/grammar.racc.rb #{args.file}"
end

task :clean do
  sh 'rm -rf build'
end