tests = [
    'unary_test',
    'comp_test'
]

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

task :tests => :build do
  for filename in tests
    my_ret = -1
    clang_ret = -1
    sh "ruby build/grammar.racc.rb tests/#{filename}.c > tests/#{filename}.ll"
    sh "clang tests/#{filename}.ll -o build/my_#{filename}.out"
    sh "./build/my_#{filename}.out" do |ok, res|
      my_ret = res.exitstatus #ENV['$?']
    end
    sh "clang tests/#{filename}.c -o build/clang_#{filename}.out"
    sh "./build/clang_#{filename}.out" do |ok, res|
      clang_ret = res.exitstatus #ENV['$?']
    end
    if my_ret != clang_ret
      puts("Test #{filename} failed : clang returns #{clang_ret}, got #{my_ret}\n")
    else
      puts("Test #{filename} succeeded : both returned #{my_ret}\n")
    end
  end
end

task :clean do
  sh 'rm -rf build'
end