@g = global i32 2

define i32 @test() {
%1 = add i32 5, 10
%2 = load i32, i32* @g
%3 = add i32 0, 4
%4 = mul i32 %2, %3
%5 = add i32 %1, %4
%v10624300_g = alloca i32
store i32 %5, i32* %v10624300_g
%6 = load i32, i32* %v10624300_g
ret i32 %6
}

define i32 @main() {
%1 = call i32 @test()
ret i32 %1
}

