int main() {
    int a = 0;
    do {
        if (a < 5 && ++a == 3)
            a = 8;
    } while (a < 5 && a != 4);

    /*
    for (int i = 0; i < 3; ++i) {
        a++;
    }
    */

    int j = 4;
    for (; j > 0; j--) {
        a++;
    }

    return a;
}