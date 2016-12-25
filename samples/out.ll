define i32 @main() {
%v11496040_x = alloca i32
%1 = add i32 0, 0
%2 = add i32 0, 1
%3 = icmp slt i32 %1, %2
%4 = zext i1 %3 to i32
store i32 %4, i32* %v11496040_x
%v11496040_y = alloca i32
%5 = add i32 0, 3
store i32 %5, i32* %v11496040_y
%v11496040_z = alloca i32
%6 = add i32 0, 4
store i32 %6, i32* %v11496040_z
%7 = load i32, i32* %v11496040_y
%8 = load i32, i32* %v11496040_z
%9 = icmp eq i32 %7, %8
%10 = zext i1 %9 to i32
store i32 %10, i32* %v11496040_x
%11 = load i32, i32* %v11496040_x
ret i32 %11
}

