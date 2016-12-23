@g = global i32 3
@h = global double 2.020000e+01
define i32 @coucou() {
%1 = load double, double* @h
%2 = fptosi double %1 to i32
ret i32 %2
}

define i32 @test() {
%1 = add i32 0, 25
%2 = load double, double* @h
%3 = sitofp i32 %1 to double
%4 = fsub double %3, %2
%5 = fptosi double %4 to i32
store i32 %5, i32* @g
%6 = load i32, i32* @g
ret i32 %6
}

define i32 @main() {
%1 = call i32 @test()
%2 = load i32, i32* @g
ret i32 %2
}

