@str_int = constant [7 x i8] c"=> %d\0A\00"
@str_double = constant [8 x i8] c"=> %lf\0A\00"

declare void @background(double)
declare void @fill(double)
declare void @stroke(double)
declare void @point(double, double)
declare void @line(double, double, double, double)
declare void @ellipse(double, double, double, double)
declare void @rectangle(double, double, double, double)
declare double @sin(double)
declare double @cos(double)
declare double @log10(double)
declare void @createCanvas(double, double)
declare i32 @printf(i8*, ...)


define void @print_int(i32 %i) {
  call i32 (i8*, ...) @printf(i8* getelementptr ([7 x i8], [7 x i8]* @str_int, i32 0, i32 0), i32 %i)
  ret void
}

define void @print_double(double %d) {
  call i32 (i8*, ...) @printf(i8* getelementptr ([8 x i8], [8 x i8]* @str_double, i32 0, i32 0), double %d)
  ret void
}


define i32 @abc(i32 %c) {
  %1 = alloca i32
  store i32 %c, i32* %1
  %2 = load i32, i32* %1
  %3 = add i32 %2, 1
  ret i32 %3
}

define i32 @main() {
  %1 = alloca i32
  store i32 8, i32* %1
  %2 = alloca i32
  store i32 8, i32* %2
  %3 = alloca double
  store double 8.550000e+01, double* %3
  %4 = load i32, i32* %2
  call void @print_int(i32 %4)
  %5 = load i32, i32* %1
  %6 = add i32 %5, 3
  call void @print_int(i32 %6)
  %7 = load double, double* %3
  %8 = fptosi double %7 to i32
  call void @print_int(i32 %8)
  %9 = load double, double* %3
  call void @print_double(double %9)
  %10 = load i32, i32* %1
  %11 = sitofp i32 %10 to double
  call void @print_double(double %11)
  %12 = load i32, i32* %1
  %13 = load i32, i32* %2
  %14 = add i32 %12, %13
  %15 = call i32 @abc(i32 %14)
  ret i32 %15
}
