int main() {
    int x = 0;
    float y = -23.34;


    x++;
    x = !x;
    x = !x;
    x--;
    x++;

    y++;
    y--;

    y = ++y;
    y = --y;
    y = y++;
    y = y--;
    y = -y;

    return x+y;
}