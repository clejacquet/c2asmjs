double coucou(int a, int b) {
    return a + b;
}

int test() {
    int b = 8;
    return b;
}

int main() {
    int c = (3 < 5);
    return coucou(test(), 6 * c) + test();
}