int g = 2;

int test() {
    int g = 5 + 10 + (g * 4);
    return g;
}

int main() {
    return test();
}