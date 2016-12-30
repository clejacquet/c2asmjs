int test() {
    int a = 2;
    a++;
    return a;
}

int main() {
    return test() + 5;
}