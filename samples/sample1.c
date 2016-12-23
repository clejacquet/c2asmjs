double coucou(int a, int b) {
    return a + b;
}

int test() {
    int b = 8;
    return b;
}

int main() {
    return coucou(test(), 6) + test();
}