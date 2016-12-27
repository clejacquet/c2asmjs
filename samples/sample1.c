int main() {
    int a = 3;
    int b = 4;
    int c = a && b;

    int d = 2;
    return c && d;
}

/*
define i32 @main() {
    %a = alloca i32
    %b = alloca i32
    store i32 3, i32* %a
    store i32 4, i32* %b
    %1 = load i32, i32* %a
    %2 = load i32, i32* %b

    %3 = icmp ne i32 0, %1
    br i1 %3, label %4, label %6

    ; <label>:4
    %5 = icmp ne i32 0, %2
    br label %6

    ; <label>:6
    %7 = phi i1 [false, %0], [%5, %4]
    %8 = zext i1 %7 to i32

    ret i32 %8
}*/