define i32 @main() {
  %v10776380_a = alloca i32
  store i32 1, i32* %v10776380_a
  %1 = add i32 0, 3
  store i32 %1, i32* %v10776380_a
  %2 = load i32, i32* %v10776380_a
  ret i32 %2
}

