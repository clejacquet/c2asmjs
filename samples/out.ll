define i32 @main() {
  %v9172500_a = alloca i32
  store i32 5, i32* %v9172500_a
  %1 = load i32, i32* %v9172500_a
  %2 = sub i32 %1, 1
  store i32 %2, i32* %v9172500_a
  ret i32 %2
}

