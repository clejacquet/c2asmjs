int g = 3;
double h = 20.2;

int coucou() {
    return h;
}

int test() {
    g = 25 - h;
    return g;
}

int main() {
    test();
    return g;
}