define i32 @main() {
  %v17576160_a = alloca i32
  store i32 0, i32* %v17576160_a
  br label %1
; <label>:1
  %2 = load i32, i32* %v17576160_a
  %3 = icmp slt i32 %2, 5
  %4 = load i32, i32* %v17576160_a
  %5 = add i32 %4, 1
  store i32 %5, i32* %v17576160_a
  %6 = icmp eq i32 %5, 3
  %7 = icmp ne i1 false, %3
  br i1 %7, label %8, label %10

; <label>:8
  %9 = icmp ne i1 false, %6
  br label %10

; <label>:10
  %11 = phi i1 [false, %1], [%9, %8]
  br i1 %11, label %12, label %14

; <label>:12
  %13 = add i32 0, 8
  store i32 %13, i32* %v17576160_a
  br label %14

; <label>:14
  br label %15
; <label>:15
  %16 = load i32, i32* %v17576160_a
  %17 = icmp slt i32 %16, 5
  %18 = load i32, i32* %v17576160_a
  %19 = icmp ne i32 %18, 4
  %20 = icmp ne i1 false, %17
  br i1 %20, label %21, label %23

; <label>:21
  %22 = icmp ne i1 false, %19
  br label %23

; <label>:23
  %24 = phi i1 [false, %15], [%22, %21]
  br i1 %24, label %1, label %25
; <label>:25
  %26 = load i32, i32* %v17576160_a
  ret i32 %26
}

