#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

char* encode_b64(const char*);
char* pad_hex(const char*);
void decode_hex(uint8_t*, const char*, size_t);
uint8_t decode_hex_char(const uint8_t);
void run_tests(void);


int main(int argc, char *argv[]) {
    run_tests();
    printf("%s\n", decode_hex(argv[1]));
    printf("%s\n", encode_b64(decode_hex(argv[1])));
}

char* pad_hex(const char *hex) {
    char *out;

    size_t len = strlen(hex);
    if (len % 2 != 0) {
        len++; // increase length for padding byte
        out = malloc(len+1); // increase length for null byte
        out[0] = '\0'; // set padding byte

        strncpy(out + 1, hex, len-1);
    } else {
        out = malloc(len+1); // increase length for null byte

        strncpy(out, hex, len);
    }

    return out;
}

void decode_hex(uint8_t *dest, const char *hex, size_t len) {
    size_t i;

    for (i = 0; i < len; ++i) {
        dest[i] = decode_hex_char(hex[i*2]) << 4 | decode_hex_char(hex[i*2+1]);
    }
}

uint8_t decode_hex_char(const uint8_t h) {
    uint8_t decoded_value;

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

char* encode_b64(const char *bytes) {
    /* TODO: add padding */
    size_t len, i, bits;
    const char *b64_symbols = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    len = strlen(bytes);
    len /= 3;
    char *out = malloc(len*4);

    for (i = 0; i < len; ++i) {
        bits = bytes[i*3] << 8 | bytes[i*3+1];
        bits = bits << 8 | bytes[i*3+2];

        out[i*4] = b64_symbols[bits >> 18];
        out[i*4+1] = b64_symbols[bits >> 12 & 63];
        out[i*4+2] = b64_symbols[bits >> 6 & 63];
        out[i*4+3] = b64_symbols[bits & 63];
    }

    return out;
}

void run_tests(void){
    const char *hex_fixture, *bytes, *expected_bytes;

    hex_fixture = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
    bytes = decode_hex(hex_fixture);
    expected_bytes = "I'm killing your brain like a poisonous mushroom";
    assert(strcmp(expected_bytes, bytes) == 0);

    bytes = encode_b64(bytes);
    expected_bytes = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t";
    assert(strcmp(expected_bytes, bytes) == 0);
}
