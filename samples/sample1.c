int main() {
    int array_length = 43;
    int array[array_length];
    float farray[array_length];

    int i = 0;
    int j = array_length-1;
    int res = 0;

    for (i; i < array_length; i++) {
        array[i] = (i+1)*(i+1.0);
        farray[i] = 0.24 * array[i];
        print_int(i);
    }

    for (j; j >= 0; j--) {
        res += farray[j];
    }

    return res % 256;
}