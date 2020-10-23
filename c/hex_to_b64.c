#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned char decode_hex_char(const unsigned char);

unsigned char decode_hex_2_tuple_be(const unsigned char h0, const unsigned char h1);

int main(int argc, char *argv[]) {
    unsigned char *out;
    char *hex;
    size_t len, i;

    hex = argv[1];
    len = strlen(hex);
    if (len % 2 != 0) {
        fprintf(stderr, "string length is not even: %ld", len);
        exit(EXIT_FAILURE);
    }
    len /= 2;

    out = malloc(len);
    memset(out, 'A', len);

    for (i = 0; i < len; ++i) {
        out[i] = decode_hex_2_tuple_be(hex[i*2], hex[i*2+1]);
    }

    printf("%s\n", out);
}

unsigned char decode_hex_2_tuple_be(const unsigned char h0, const unsigned char h1) {
    unsigned char byte;

    byte = (decode_hex_char(h0) << 4) + decode_hex_char(h1);

    return byte;
}

unsigned char decode_hex_char(const unsigned char h) {
    unsigned char decoded_value;

    if (h >= '0' && h <= '9') {
        decoded_value = h - '0';
    } else if (h >= 'a' && h <= 'f') {
        decoded_value = h - 'a' + 10;
    } else if (h >= 'A' && h <= 'F') {
        decoded_value = h - 'A' + 10;
    } else {
        fprintf(stderr, "non hex value: %d\n", h);
        exit(EXIT_FAILURE);
    }

    return decoded_value;
}
