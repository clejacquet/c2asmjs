define i32 @main() {
  %v8792320_a = alloca i32
  store i32 0, i32* %v8792320_a
  br label %1
; <label>:1
  %2 = load i32, i32* %v8792320_a
  %3 = icmp slt i32 %2, 5
  br i1 %3, label %4, label %20
; <label>:4
  %5 = load i32, i32* %v8792320_a
  %6 = icmp sgt i32 %5, 3
  %7 = load i32, i32* %v8792320_a
  %8 = icmp eq i32 %7, 4
  %9 = icmp ne i1 false, %6
  br i1 %9, label %10, label %12

; <label>:10
  %11 = icmp ne i1 false, %8
  br label %12

; <label>:12
  %13 = phi i1 [false, %4], [%11, %10]
  br i1 %13, label %14, label %16

; <label>:14
  %15 = add i32 0, 5
  store i32 %15, i32* %v8792320_a
  br label %16

; <label>:16
  %17 = load i32, i32* %v8792320_a
  %18 = load i32, i32* %v8792320_a
  %19 = add i32 %18, 1
  store i32 %19, i32* %v8792320_a
  br label %1
; <label>:20
  %21 = load i32, i32* %v8792320_a
  ret i32 %21
}

