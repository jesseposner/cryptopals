#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

char* pad_hex(const char*);
void decode_hex(uint8_t*, const char*, size_t);
uint8_t decode_hex_char(const uint8_t);
char* encode_b64(const uint8_t*, size_t);
void run_tests(void);


int main(int argc, char *argv[]) {
    run_tests();
    /* allocates memory that must be freed */
    const char *hex_string = pad_hex(argv[1]);
    size_t len = strlen(hex_string) / 2;
    uint8_t *bytes = malloc(len);
    decode_hex(bytes, hex_string, len);
    free((void*) hex_string);
    /* allocates memory that must be freed */
    const char *b64_string = encode_b64(bytes, len);
    free(bytes);
    printf("%s\n", b64_string);
    free((void*) b64_string);
}

char* pad_hex(const char *hex) {
    char *out;

    size_t len = strlen(hex);
    if (len % 2 != 0) {
        len++; // increase length for padding byte
        out = malloc(len+1); // increase length for null byte
        out[0] = '0'; // set padding byte

        strncpy(out+1, hex, len-1);
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

char* encode_b64(const uint8_t *bytes, size_t inlen) {
    size_t i, buf, remainder, b64_strlen;

    const char *b64_symbols = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    remainder = inlen % 3;
    inlen /= 3;
    b64_strlen = inlen*4+(remainder+3 & 4);
    char *out = malloc(b64_strlen+1);
    out[b64_strlen] = '\0';

    for (i = 0; i < inlen; ++i) {
        buf = bytes[i*3] << 8 | bytes[i*3+1];
        buf = buf << 8 | bytes[i*3+2];

        out[i*4] = b64_symbols[buf >> 18];
        out[i*4+1] = b64_symbols[buf >> 12 & 63];
        out[i*4+2] = b64_symbols[buf >> 6 & 63];
        out[i*4+3] = b64_symbols[buf & 63];
    }

    if (remainder != 0) {
        buf = bytes[inlen*3] << 8;
        if (remainder == 2)
            buf = buf | bytes[inlen*3+1];
        out[inlen*4] = b64_symbols[buf >> 10];
        out[inlen*4+1] = b64_symbols[buf >> 4 & 63];
        out[inlen*4+2] = remainder == 1 ? '=' : b64_symbols[buf << 2 & 63];
        out[inlen*4+3] = '=';
    }

    return out;
}

void run_tests(){
    const char *hex_fixture = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
    size_t len = strlen(hex_fixture) / 2;
    uint8_t *bytes = malloc(len);
    const char *expected_bytes = "I'm killing your brain like a poisonous mushroom";
    decode_hex(bytes, hex_fixture, len);
    assert(memcmp(expected_bytes, bytes, len) == 0);

    const char *b64_string = encode_b64(bytes, len);
    free(bytes);
    expected_bytes = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t";
    assert(strcmp(expected_bytes, b64_string) == 0);
}
