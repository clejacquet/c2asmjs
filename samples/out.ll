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


define i32 @main() {
  %1 = alloca i32
  store i32 8, i32* %1
  %2 = alloca i32
  store i32 8, i32* %2
  %3 = load i32, i32* %1
  %4 = load i32, i32* %2
  %5 = add i32 %3, %4
  ret i32 %5
}
