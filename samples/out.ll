define double @coucou(i32 %a20639500_a, i32 %a20639500_b) {
%v20639500_a = alloca i32
store i32 %a20639500_a, i32* %v20639500_a
%v20639500_b = alloca i32
store i32 %a20639500_b, i32* %v20639500_b
%1 = load i32, i32* %v20639500_a
%2 = load i32, i32* %v20639500_b
%3 = add i32 %1, %2
%4 = sitofp i32 %3 to double
ret double %4
}

define i32 @test() {
%1 = add i32 0, 8
%v20637280_b = alloca i32
store i32 %1, i32* %v20637280_b
%2 = load i32, i32* %v20637280_b
ret i32 %2
}

define i32 @main() {
%1 = call i32 @test()
%2 = add i32 0, 6
%3 = call double @coucou(i32 %1, i32 %2)
%4 = call i32 @test()
%5 = sitofp i32 %4 to double
%6 = fadd double %3, %5
%7 = fptosi double %6 to i32
ret i32 %7
}

