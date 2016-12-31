declare void @background(double)

declare void @fill(double)

declare void @stroke(double)

declare void @ellipse(double, double, double, double)

declare void @rectangle(double, double, double, double)

declare double @sin(double)

declare double @cos(double)

declare void @createCanvas(double, double)

@angle = common global double 0.000000e+00

define void @draw() {
  %1 = load double, double* @angle
  %2 = fadd double %1, 1.000000e-02
  store double %2, double* @angle
  ret void
}

define i32 @main() {
  store double 0.000000e+00, double* @angle
  %1 = alloca i32
  store i32 0, i32* %1
  br label %2
; <label>:2
  %3 = load i32, i32* %1
  %4 = icmp slt i32 %3, 150
  br i1 %4, label %5, label %8
; <label>:5
  call void @draw()
  %6 = load i32, i32* %1
  %7 = add i32 %6, 1
  store i32 %7, i32* %1
  br label %2
; <label>:8
  %9 = load double, double* @angle
  %10 = fptosi double %9 to i32
  ret i32 %10
}

