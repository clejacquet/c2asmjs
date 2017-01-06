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

@w = common global double 0.000000e+00
@h = common global double 0.000000e+00
@angle = common global double 0.000000e+00
@angle_dir = common global i32 0
@N = common global i32 0

define void @my_setup() {
  store double 6.400000e+02, double* @w
  store double 4.800000e+02, double* @h
  store double 0.000000e+00, double* @angle
  store i32 0, i32* @angle_dir
  store i32 200, i32* @N
  %1 = load double, double* @w
  %2 = load double, double* @h
  call void @createCanvas(double %1, double %2)
  ret void
}

define void @my_draw() {
  %1 = alloca i32
  store i32 0, i32* %1
  %2 = alloca double
  call void @background(double 0.000000e+00)
  store i32 0, i32* %1
  br label %3

; <label>:3
  %4 = load i32, i32* %1
  %5 = load i32, i32* @N
  %6 = icmp slt i32 %4, %5
  br i1 %6, label %7, label %52

; <label>:7
  %8 = load i32, i32* %1
  %9 = sitofp i32 %8 to double
  %10 = fmul double 2.550000e+02, %9
  %11 = load i32, i32* @N
  %12 = sitofp i32 %11 to double
  %13 = fdiv double %10, %12
  call void @fill(double %13)
  %14 = load i32, i32* @N
  %15 = load i32, i32* %1
  %16 = sub i32 %14, %15
  %17 = sitofp i32 %16 to double
  %18 = fmul double 2.550000e+02, %17
  %19 = load i32, i32* @N
  %20 = sitofp i32 %19 to double
  %21 = fdiv double %18, %20
  call void @stroke(double %21)
  %22 = load i32, i32* %1
  %23 = load double, double* @angle
  %24 = sitofp i32 %22 to double
  %25 = fadd double %24, %23
  store double %25, double* %2
  %26 = load double, double* @w
  %27 = fdiv double %26, 2.000000e+00
  %28 = load i32, i32* %1
  %29 = load double, double* %2
  %30 = call double @sin(double %29)
  %31 = sitofp i32 %28 to double
  %32 = fmul double %31, %30
  %33 = fadd double %27, %32
  %34 = load double, double* @h
  %35 = fdiv double %34, 2.000000e+00
  %36 = load i32, i32* %1
  %37 = load double, double* %2
  %38 = call double @cos(double %37)
  %39 = sitofp i32 %36 to double
  %40 = fmul double %39, %38
  %41 = fadd double %35, %40
  %42 = load i32, i32* %1
  %43 = load double, double* @angle
  %44 = sitofp i32 %42 to double
  %45 = fmul double %44, %43
  %46 = load i32, i32* %1
  %47 = load double, double* @angle
  %48 = sitofp i32 %46 to double
  %49 = fmul double %48, %47
  call void @ellipse(double %33, double %41, double %45, double %49)
  %50 = load i32, i32* %1
  %51 = add i32 %50, 1
  store i32 %51, i32* %1
  br label %3

; <label>:52
  %53 = load i32, i32* @angle_dir
  %54 = icmp eq i32 %53, 0
  br i1 %54, label %55, label %62

; <label>:55
  %56 = load double, double* @angle
  %57 = fadd double %56, 1.000000e-02
  store double %57, double* @angle
  %58 = load double, double* @angle
  %59 = fcmp ogt double %58, 2.000000e+00
  br i1 %59, label %60, label %61

; <label>:60
  store i32 1, i32* @angle_dir
  br label %61

; <label>:61
  br label %73

; <label>:62
  %63 = load i32, i32* @angle_dir
  %64 = icmp eq i32 %63, 1
  br i1 %64, label %65, label %72

; <label>:65
  %66 = load double, double* @angle
  %67 = fsub double %66, 1.000000e-02
  store double %67, double* @angle
  %68 = load double, double* @angle
  %69 = fcmp olt double %68, -2.000000e+00
  br i1 %69, label %70, label %71

; <label>:70
  store i32 0, i32* @angle_dir
  br label %71

; <label>:71
  br label %72

; <label>:72
  br label %73

; <label>:73
  ret void
}