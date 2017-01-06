int a = 3;
float x = 7.432;

int add(int a, int b) {
    return a + b;
}

float mult(float x, int y) {
    return add(x,x) * y;
}

int main() {
    a += 5;
    float y = x;

    return a + mult(x, y);
}