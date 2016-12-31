double angle;

void draw() {
    angle += 0.01;
}

int main() {
    angle = 0;

    int i = 0;
    for (i = 0; i < 150; i++) {
        draw();
    }

    return angle;
}