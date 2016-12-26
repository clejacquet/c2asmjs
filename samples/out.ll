define i32 @main() {
%v6780040_x = alloca i32
store i32 0, i32* %v6780040_x
%1 = load i32, i32* %v6780040_x
%2 = sitofp i32 %1 to double
%3 = fcmp oge double %2, 5.000000e-01
%4 = zext i1 %3 to i32
ret i32 %4
}

