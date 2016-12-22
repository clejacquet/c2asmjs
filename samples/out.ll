define double @coucou() {
%1 = fadd double 0.000000e+00, 2.200000e-01
ret double %1
}

define i32 @main() {
%1 = add i32 0, 4
%2 = add i32 0, 3
%3 = add i32 0, 7
%4 = add i32 %2, %3
%5 = add i32 0, 5
%6 = sdiv i32 %4, %5
%7 = mul i32 %1, %6
ret i32 %7
}

