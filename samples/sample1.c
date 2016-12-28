int test() {
    double b = 4.5;
    int a = 5;

    if (1) {
        if (a || b) {
            a = b + 2;
        }
    }

    return a;
}

int main() {
    return test();
}