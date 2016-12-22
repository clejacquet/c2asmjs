task default: :build

task :build do
  sh 'mkdir -p build'
  sh 'rex scanner.rex -o build/scanner.rex.rb'
  sh 'racc grammar.racc -o build/grammar.racc.rb'
end

task :run, [:file] => [:build] do |t, args|
  ruby "build/grammar.racc.rb #{args.file}"
end

task :test, [:file] => [:build] do |t, args|
  sh "ruby build/grammar.racc.rb #{args.file} > samples/out.ll"
  sh 'clang samples/out.ll -target x86_64-unknown-linux-gnu -o samples/out'
  sh 'samples/out; echo $? 1>&2'
end

task :clean do
  sh 'rm -rf build'
end