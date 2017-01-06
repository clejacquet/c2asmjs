tests =
    %w(array_test
       unary_test
       comp_test
       cond_test
       shift_test
       or_and
       basic_oper_test
       for_test
       while_test
    )

=begin Tests d'erreur de compilation
errors/already_defined_error
errors/identifier_not_defined_error
errors/missing_return_value
errors/non_integer_shift
errors/unknown_conversion
=end

task default: :build

task :build do
  sh 'mkdir -p build'
  sh 'rex scanner.rex -o build/scanner.rex.rb'
  sh 'racc grammar.racc -o build/grammar.racc.rb'
end

task :compile, [:file] => [:build] do |t, args|
  ruby "build/grammar.racc.rb #{args.file}"
end

task :run, [:file] => [:build] do |t, args|
  sh "ruby build/grammar.racc.rb #{args.file} > build/out.ll"
  sh 'clang build/out.ll -target x86_64-unknown-linux-gnu -o build/out 2> /dev/null'
  sh 'build/out; echo $? 1>&2'
end

task :test, [:file] => :build do |t, args|
  my_ret = -1
  clang_ret = -1
  filename = args.file

  sh "ruby build/grammar.racc.rb #{filename} > build/out.ll"
  sh 'clang build/out.ll -o build/my_test.out'
  sh "./build/my_test.out" do |ok, res|
    my_ret = res.exitstatus #ENV['$?']
  end
  sh "clang #{filename} -o build/clang_test.out "
  sh "./build/clang_test.out" do |ok, res|
    clang_ret = res.exitstatus #ENV['$?']
  end
  if my_ret != clang_ret
    puts("Test #{filename} failed : clang returns #{clang_ret}, got #{my_ret}\n")
  else
    puts("Test #{filename} succeeded : both returned #{my_ret}\n")
  end
end

task :tests => :build do
  for filename in tests
    my_ret = -1
    clang_ret = -1

    sh "ruby build/grammar.racc.rb tests/#{filename}.c > build/#{filename}.ll"
    sh "clang build/#{filename}.ll -o build/my_#{filename}.out 2> /dev/null"
    sh "./build/my_#{filename}.out" do |ok, res|
      my_ret = res.exitstatus #ENV['$?']
    end
    sh "clang tests/#{filename}.c -o build/clang_#{filename}.out 2> /dev/null"
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

=begin
task :test_error_handling => :build do
  sh "ruby build/grammar.racc.rb tests/error_handling_test.c"
end
=end

task :clean do
  sh 'rm -rf build'
end