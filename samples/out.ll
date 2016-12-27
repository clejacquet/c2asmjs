define i32 @main() {
%v17407100_a = alloca i32
store i32 3, i32* %v17407100_a
%v17407100_b = alloca i32
store i32 4, i32* %v17407100_b
%1 = load i32, i32* %v17407100_a
%2 = load i32, i32* %v17407100_b
%3 = icmp ne i32 0, %1
br i1 %3, label %4, label %6
; <label>:4
%5 = icmp ne i32 0, %2
br label %6
; <label>:6
%7 = phi i1 [false, %0], [%5, %4]
%v17407100_c = alloca i32
%8 = zext i1 %7 to i32
store i32 %8, i32* %v17407100_c
%v17407100_d = alloca i32
store i32 2, i32* %v17407100_d
%9 = load i32, i32* %v17407100_c
%10 = load i32, i32* %v17407100_d
%11 = icmp ne i32 0, %9
br i1 %11, label %12, label %14
; <label>:12
%13 = icmp ne i32 0, %10
br label %14
; <label>:14
%15 = phi i1 [false, %6], [%13, %12]
%16 = zext i1 %15 to i32
ret i32 %16
}

