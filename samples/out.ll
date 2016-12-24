define i32 @test() {
%1 = add i32 0, 5
%2 = add i32 0, 10
%3 = add i32 %1, %2
%v19595640_g = alloca i32
store i32 %3, i32* %v19595640_g
%4 = load i32, i32* %v19595640_g
ret i32 %4
}

define i32 @main() {
%1 = call i32 @test()
ret i32 %1
}

