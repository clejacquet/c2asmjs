int main() {
    int array_length = 3;
    int array[3];

    int i = 0;
    int j = array_length-1;
    int res = 0;
    for (i; i < array_length; i++) {
        array[i] = i*i;
    }

    for (j; j >= 0; j--) {
        res += array[j];
    }

    return res % 256;
}