int test() {
    int a = 0;

    if (a) {
        a = 2;
    } else {
        int b = 2;
        if (b && 4) {
            a = 3;
        } else {
            a = 4;
        }
    }

    return a;
}

int main() {
    return test();
}