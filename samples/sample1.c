int abc(int c) {
    return c + 1;
}

int main() {
    int a, b = 8;
    double d = 85.5;

    print_int(b);
    print_int(a + 3);
    print_int(d);
    print_double(d);
    print_double(a);

    return abc(a + b);
}