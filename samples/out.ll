define double @coucou() {
%1 = fadd double 0.000000e+00, 2.200000e-01
ret double %1
}

define void @test() {
%1 = add i32 0, 8
%b = alloca i32
store i32 %1, i32* %b
ret void
}

define i32 @main() {
%1 = fadd double 0.000000e+00, 5.500000e+00
%2 = fadd double 0.000000e+00, 5.600000e+00
%3 = add i32 0, 2
%4 = sitofp i32 %3 to double
%5 = fsub double %2, %4
%6 = fadd double %1, %5
%7 = fptosi double %6 to i32
ret i32 %7
}

