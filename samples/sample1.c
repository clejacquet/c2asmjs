int g = 3;
double h = 20.2;

int coucou() {
    return g;
}

int test() {
    int g = 2;
    return g;
}

int main() {
    return test();
}