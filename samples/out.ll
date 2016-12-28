define i32 @test() {
  %v13574620_b = alloca double
  store double 4.500000e+00, double* %v13574620_b
  %v13574620_a = alloca i32
  store i32 5, i32* %v13574620_a
  %1 = add i32 0, 1
  %2 = icmp ne i32 1, 0
  br i1 %2, label %3, label %17

; <label>:3
  %4 = load i32, i32* %v13574620_a
  %5 = load double, double* %v13574620_b
  %6 = sitofp i32 %4 to double
  %7 = fcmp one double 0.000000e+00, %6
  br i1 %7, label %10, label %8

; <label>:8
  %9 = fcmp one double 0.000000e+00, %5
  br label %10

; <label>:10
  %11 = phi i1 [true, %3], [%9, %8]
  br i1 %11, label %12, label %16

; <label>:12
  %13 = load double, double* %v13574620_b
  %14 = fadd double %13, 2.000000e+00
  %15 = fptosi double %14 to i32
  store i32 %15, i32* %v13574620_a
  br label %16

; <label>:16
  br label %17

; <label>:17
  %18 = load i32, i32* %v13574620_a
  ret i32 %18
}

define i32 @main() {
  %1 = call i32 @test()
  ret i32 %1
}

