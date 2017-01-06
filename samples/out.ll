@str_int = constant [7 x i8] c"=> %d\0A\00"
@str_double = constant [8 x i8] c"=> %lf\0A\00"

declare i8* @llvm.stacksave()
declare void @llvm.stackrestore(i8*)
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
  %1 = alloca i32
  store i32 43, i32* %1
  %2 = alloca i8*
  %3 = load i32, i32* %1
  %4 = sext i32 %3 to i64
  store i8* %5, i8** %2
  %5 = call i8* @llvm.stacksave()
  %6 = alloca i32, i64 %4
  %7 = alloca i8*
  %8 = load i32, i32* %1
  %9 = sext i32 %8 to i64
  store i8* %10, i8** %7
  %10 = call i8* @llvm.stacksave()
  %11 = alloca double, i64 %9
  %12 = alloca i32
  store i32 0, i32* %12
  %13 = load i32, i32* %1
  %14 = sub i32 %13, 1
  %15 = alloca i32
  store i32 %14, i32* %15
  %16 = alloca i32
  store i32 0, i32* %16
  %17 = load i32, i32* %12
  br label %18

; <label>:18
  %19 = load i32, i32* %12
  %20 = load i32, i32* %1
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %46

; <label>:22
  %23 = load i32, i32* %12
  %24 = add i32 %23, 1
  %25 = load i32, i32* %12
  %26 = sitofp i32 %25 to double
  %27 = fadd double %26, 1.000000e+00
  %28 = sitofp i32 %24 to double
  %29 = fmul double %28, %27
  %30 = fptosi double %29 to i32
  %31 = load i32, i32* %12
  %32 = sext i32 %31 to i64
  %33 = getelementptr inbounds i32, i32* %6, i64 %32
  store i32 %30, i32* %33
  %34 = load i32, i32* %12
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i32, i32* %6, i64 %35
  %37 = load i32, i32* %36
  %38 = sitofp i32 %37 to double
  %39 = fmul double 2.400000e-01, %38
  %40 = load i32, i32* %12
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds double, double* %11, i64 %41
  store double %39, double* %42
  %43 = load i32, i32* %12
  call void @print_int(i32 %43)
  %44 = load i32, i32* %12
  %45 = add i32 %44, 1
  store i32 %45, i32* %12
  br label %18

; <label>:46
  %47 = load i32, i32* %15
  br label %48

; <label>:48
  %49 = load i32, i32* %15
  %50 = icmp sge i32 %49, 0
  br i1 %50, label %51, label %62

; <label>:51
  %52 = load i32, i32* %16
  %53 = load i32, i32* %15
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds double, double* %11, i64 %54
  %56 = load double, double* %55
  %57 = sitofp i32 %52 to double
  %58 = fadd double %57, %56
  %59 = fptosi double %58 to i32
  store i32 %59, i32* %16
  %60 = load i32, i32* %15
  %61 = sub i32 %60, 1
  store i32 %61, i32* %15
  br label %48

; <label>:62
  %63 = load i32, i32* %16
  %64 = srem i32 %63, 256
  ret i32 %64
}
