@g = global i32 2

define i32 @test() {
%v14905600_g = alloca i32
store i32 27, i32* %v14905600_g
%1 = load i32, i32* %v14905600_g
ret i32 %1
}

define i32 @main() {
%1 = call i32 @test()
ret i32 %1
}

