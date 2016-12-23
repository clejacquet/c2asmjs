@g = global i32 3
@h = global double 2.020000e+01
define i32 @coucou() {
%1 = load i32, i32* @g
ret i32 %1
}

define i32 @test() {
%1 = add i32 0, 2
store i32 %1, i32* @g
%2 = load i32, i32* @g
ret i32 %2
}

define i32 @main() {
%1 = call i32 @test()
ret i32 %1
}

