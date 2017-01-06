int main() {
    int array_length = 3;
    int array[3];
    float farray[3];

    int i = 0;
    int j = array_length-1;
    int res = 0;
    for (i; i < array_length; i++) {
        array[i] = (i+1)*(i+1.0);
        farray[i] = 0.24 * array[i];
    }

    for (j; j >= 0; j--) {
        res += farray[j];
    }

    return res%256;
}