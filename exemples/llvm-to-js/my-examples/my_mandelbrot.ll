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
@bail_out = common global double 0.000000e+00
@zoom_factor = common global double 0.000000e+00
@zoom = common global double 0.000000e+00

define void @my_setup() {
  store double 6.400000e+02, double* @w
  store double 4.800000e+02, double* @h
  store double 2.000000e+00, double* @bail_out
  store double 1.400000e+00, double* @zoom_factor
  %1 = load double, double* @w
  %2 = fmul double %1, 2.529688e-01
  store double %2, double* @zoom
  %3 = load double, double* @w
  %4 = load double, double* @h
  call void @createCanvas(double %3, double %4)
  ret void
}

define void @my_draw() {
  %1 = alloca i32
  %2 = alloca i32
  %3 = alloca i32
  %4 = alloca i32
  %5 = alloca double
  %6 = alloca double
  %7 = alloca double
  %8 = alloca double
  %9 = alloca double
  %10 = alloca double
  %11 = alloca double
  %12 = alloca double
  %13 = alloca double
  %14 = alloca double
  %15 = load double, double* @w
  %16 = fdiv double %15, 2.000000e+00
  %17 = fmul double %16, 4.971591e-02
  %18 = load double, double* @zoom
  %19 = call double @log10(double %18)
  %20 = fmul double %17, %19
  %21 = fptosi double %20 to i32
  store i32 %21, i32* %4
  store double -8.006710e-01, double* %9
  store double 1.583920e-01, double* %10
  store i32 0, i32* %2
  store i32 0, i32* %2
  br label %22

; <label>:22
  %23 = load i32, i32* %2
  %24 = load double, double* @h
  %25 = sitofp i32 %23 to double
  %26 = fcmp olt double %25, %24
  br i1 %26, label %27, label %119

; <label>:27
  store i32 0, i32* %1
  store i32 0, i32* %1
  br label %28

; <label>:28
  %29 = load i32, i32* %1
  %30 = load double, double* @w
  %31 = sitofp i32 %29 to double
  %32 = fcmp olt double %31, %30
  br i1 %32, label %33, label %116

; <label>:33
  store double 0.000000e+00, double* %11
  %34 = load double, double* %9
  %35 = load i32, i32* %1
  %36 = load double, double* @w
  %37 = fdiv double %36, 2.000000e+00
  %38 = sitofp i32 %35 to double
  %39 = fsub double %38, %37
  %40 = load double, double* @zoom
  %41 = fdiv double %39, %40
  %42 = fadd double %34, %41
  store double %42, double* %7
  %43 = load double, double* %7
  store double %43, double* %5
  %44 = load double, double* %10
  %45 = load i32, i32* %2
  %46 = load double, double* @h
  %47 = fdiv double %46, 2.000000e+00
  %48 = sitofp i32 %45 to double
  %49 = fsub double %48, %47
  %50 = load double, double* @zoom
  %51 = fdiv double %49, %50
  %52 = fadd double %44, %51
  store double %52, double* %8
  %53 = load double, double* %8
  store double %53, double* %6
  store i32 0, i32* %3
  store i32 0, i32* %3
  br label %54

; <label>:54
  %55 = load i32, i32* %3
  %56 = load i32, i32* %4
  %57 = icmp sle i32 %55, %56
  %58 = load double, double* %11
  %59 = load double, double* @bail_out
  %60 = load double, double* @bail_out
  %61 = fmul double %59, %60
  %62 = fcmp olt double %58, %61
  %63 = icmp ne i1 false, %57
  br i1 %63, label %64, label %66

; <label>:64
  %65 = icmp ne i1 false, %62
  br label %66

; <label>:66
  %67 = phi i1 [false, %54], [%65, %64]
  br i1 %67, label %68, label %95

; <label>:68
  %69 = load double, double* %5
  %70 = load double, double* %5
  %71 = fmul double %69, %70
  %72 = load double, double* %6
  %73 = load double, double* %6
  %74 = fmul double %72, %73
  %75 = fsub double %71, %74
  %76 = load double, double* %7
  %77 = fadd double %75, %76
  store double %77, double* %12
  %78 = load double, double* %5
  %79 = fmul double 2.000000e+00, %78
  %80 = load double, double* %6
  %81 = fmul double %79, %80
  %82 = load double, double* %8
  %83 = fadd double %81, %82
  store double %83, double* %13
  %84 = load double, double* %12
  store double %84, double* %5
  %85 = load double, double* %13
  store double %85, double* %6
  %86 = load double, double* %12
  %87 = load double, double* %12
  %88 = fmul double %86, %87
  %89 = load double, double* %13
  %90 = load double, double* %13
  %91 = fmul double %89, %90
  %92 = fadd double %88, %91
  store double %92, double* %11
  %93 = load i32, i32* %3
  %94 = add i32 %93, 1
  store i32 %94, i32* %3
  br label %54

; <label>:95
  %96 = load i32, i32* %3
  %97 = load i32, i32* %4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %107

; <label>:99
  %100 = load i32, i32* %3
  %101 = sitofp i32 %100 to double
  %102 = fmul double 1.000000e+00, %101
  %103 = load i32, i32* %4
  %104 = sitofp i32 %103 to double
  %105 = fdiv double %102, %104
  %106 = fmul double %105, 2.550000e+02
  store double %106, double* %14
  br label %108

; <label>:107
  store double 0.000000e+00, double* %14
  br label %108

; <label>:108
  %109 = load double, double* %14
  call void @stroke(double %109)
  %110 = load i32, i32* %1
  %111 = sitofp i32 %110 to double
  %112 = load i32, i32* %2
  %113 = sitofp i32 %112 to double
  call void @point(double %111, double %113)
  %114 = load i32, i32* %1
  %115 = add i32 %114, 1
  store i32 %115, i32* %1
  br label %28

; <label>:116
  %117 = load i32, i32* %2
  %118 = add i32 %117, 1
  store i32 %118, i32* %2
  br label %22

; <label>:119
  %120 = load double, double* @zoom
  %121 = load double, double* @zoom_factor
  %122 = fmul double %120, %121
  store double %122, double* @zoom
  ret void
}