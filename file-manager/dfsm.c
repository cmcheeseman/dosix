#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int verifybootable(char *filename) {
  FILE *image = fopen(filename, "rb");
  uint8_t *bytes = malloc(512);
  if ((bytes == NULL) || (image == NULL)){
    printf("error: couldn't read file");
    fclose(image);
    free(bytes);
    return -1;
  }
  fread(bytes, 512, 1, image);
  if ((bytes[511] == 0xAA) && (bytes[510] == 0x55)) {
    fclose(image);
    free(bytes);
    return 0;
  } else {
    fclose(image);
    free(bytes);
    return 1;
  }
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("dfsm [FILENAME]\n");
    return -1;
  }
  if (verifybootable(argv[1]) == 0) {
    printf("the file is bootable\n");
  } else {
    printf("the file is not bootable\n");
  }
  return 0;
}
