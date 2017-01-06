int main() {
    int a = 2;
    int b = -2;

    b = b >> 1;
    a = a << 1;

    return (a + b) << 2;
}