#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned char hexdigit(const unsigned char hex);
unsigned char hexbyte(const unsigned char d1, const unsigned char d2);

int main(int argc, char *argv[])
{
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
    out[i] = hexbyte(hex[i*2], hex[i*2+1]);
  }

  printf("%s\n", out);
}

unsigned char hexbyte(const unsigned char d1, const unsigned char d2)
{
  unsigned char byte;

  byte = (hexdigit(d1) << 4) + hexdigit(d2);

  return byte;
}

unsigned char hexdigit(const unsigned char hex)
{
  unsigned char decoded_value;

  if (hex >= '0' && hex <= '9') {
    decoded_value = hex - '0';
  } else if (hex >= 'a' && hex <= 'f') {
    decoded_value = hex - 'a' + 10;
  } else if (hex >= 'A' && hex <= 'F') {
    decoded_value = hex - 'A' + 10;
  } else {
    fprintf(stderr, "non hex value: %d\n", hex);
    exit(EXIT_FAILURE);
  }

  return decoded_value;
}
