#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

int verifybootable(char *filename) {
  FILE *image = fopen(filename, "rb");
  uint8_t *bytes = malloc(512);
  if ((bytes == NULL) || (image == NULL)){
    printf("error: couldn't read file\n");
    exit(1);
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

int ls(char *filename) {
  FILE *image = fopen(filename, "rb");
  uint8_t *bytes = malloc(7 * 512);
  if ((image == NULL) || (bytes == NULL)) {
    printf("failed to read file\n");
    exit(1);
  }
  fread(bytes, 3584, 1, image);
  int i = 0x600;
  while (i < 0xe00) {
    if (bytes[i + 1] == 0) {
      break;
    }
    printf("%.*s\n", 5, (char *)&bytes[i + 3]);
    i += 9;
  }
  return 0;
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("dfsm [FILENAME]\n");
    return -1;
  }
  if (strcmp(argv[1], "-vb") == 0) {
    if (verifybootable(argv[2]) == 0) {
      printf("the file is bootable\n");
    } else {
      printf("the file is not bootable\n");
    }
  } else {
    ls(argv[2]);
  }
  return 0;
}
