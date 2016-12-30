define i32 @test() {
  %1 = add i32 0, 2
  %v14639540_a = alloca i32
  store i32 %1, i32* %v14639540_a
  %2 = load i32, i32* %v14639540_a
  %3 = load i32, i32* %v14639540_a
  %4 = add i32 0, 1
  %5 = add i32 %3, %4
  store i32 %5, i32* %v14639540_a
  %6 = load i32, i32* %v14639540_a
  ret i32 %6
}

define i32 @main() {
  %1 = call i32 @test()
  %2 = add i32 0, 5
  %3 = add i32 %1, %2
  ret i32 %3
}

