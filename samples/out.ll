define double @coucou() {
%1 = fadd double 0.000000e+00, 2.200000e-01
ret double %1
}
define i32 @main() {
%d = alloca i32
%1 = add i32 0, 9
%a = alloca i32
store i32 %1, i32* %a
%b = alloca i32
store i32 %1, i32* %b
%2 = load i32, i32* %a
%3 = add i32 0, 2
%4 = sub i32 %2, %3
%5 = add i32 0, 7
%6 = add i32 %4, %5
store i32 %6, i32* %d
%7 = fadd double 0.000000e+00, 5.025000e+01
%c = alloca double
store double %7, double* %c
%8 = load i32, i32* %d
ret i32 %8
}