int main() {
    int x;
    x = (0 < 1);
    x = (0 >= 0.5); //should cast 0.5 to 0 and return false or cast 0 to 0.0 and return true ?
    int y;
    y = 3;
    int z;
    z = 4;
//    x = (y == z);

    return x;
}