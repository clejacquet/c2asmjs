define i32 @test() {
  %v6192780_a = alloca i32
  store i32 0, i32* %v6192780_a
  %1 = load i32, i32* %v6192780_a
  %2 = load i32, i32* %v6192780_a
  %3 = icmp ne i32 %2, 0
  br i1 %3, label %4, label %6

; <label>:4
  %5 = add i32 0, 2
  store i32 %5, i32* %v6192780_a
  br label %18

; <label>:6
  %v6190020_b = alloca i32
  store i32 2, i32* %v6190020_b
  %7 = load i32, i32* %v6190020_b
  %8 = icmp ne i32 0, %7
  br i1 %8, label %9, label %11

; <label>:9
  %10 = icmp ne i32 0, 4
  br label %11

; <label>:11
  %12 = phi i1 [false, %6], [%10, %9]
  br i1 %12, label %13, label %15

; <label>:13
  %14 = add i32 0, 3
  store i32 %14, i32* %v6192780_a
  br label %17

; <label>:15
  %16 = add i32 0, 4
  store i32 %16, i32* %v6192780_a
  br label %17

; <label>:17
  br label %18

; <label>:18
  %19 = load i32, i32* %v6192780_a
  ret i32 %19
}

define i32 @main() {
%1 = call i32 @test()
ret i32 %1
}

