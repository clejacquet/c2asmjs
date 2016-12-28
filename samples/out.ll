define i32 @main() {
  %v9134280_a = alloca i32
  store i32 0, i32* %v9134280_a
  %v9134280_b = alloca i32
  store i32 1, i32* %v9134280_b
  %v9134280_c = alloca i32
  store i32 0, i32* %v9134280_c
  %1 = load i32, i32* %v9134280_a
  %2 = load i32, i32* %v9134280_b
  %3 = icmp ne i32 0, %1
  br i1 %3, label %6, label %4

; <label>:4
  %5 = icmp ne i32 0, %2
  br label %6

; <label>:6
  %7 = phi i1 [true, %0], [%5, %4]
  %8 = load i32, i32* %v9134280_c
  %9 = zext i1 %7 to i32
  %10 = icmp ne i32 0, %9
  br i1 %10, label %13, label %11

; <label>:11
  %12 = icmp ne i32 0, %8
  br label %13

; <label>:13
  %14 = phi i1 [true, %6], [%12, %11]
  %15 = zext i1 %14 to i32
  ret i32 %15
}

