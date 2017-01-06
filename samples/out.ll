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


define i32 @main() {
  %1 = alloca [3 x i32]
  %2 = add i32 0, 5
  %3 = add i32 0, 2
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 %4
  store i32 %2, i32* %5
  %6 = add i32 0, 4
  %7 = add i32 0, 1
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 %8
  store i32 %6, i32* %9
  %10 = add i32 0, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [3 x i32], [3 x i32]* %1, i64 0, i64 %11
  %13 = load i32, i32* %12
  ret i32 %13
}
