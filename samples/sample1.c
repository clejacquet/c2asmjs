int main() {
    int a = 0;
    do {
        if (a < 5 && ++a == 3)
            a = 8;
    } while (a < 5 && a != 4);

    return a;
}