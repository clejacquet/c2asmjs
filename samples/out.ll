define i32 @main() {
  %v19077520_a = alloca i32
  store i32 1, i32* %v19077520_a
  store i32 3, i32* %v19077520_a
  %1 = load i32, i32* %v19077520_a
  ret i32 %1
}

