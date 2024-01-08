#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define SAMPLES 16

void intToBinary(int n, char* str)
{
    printf("%d\n", n);
    short i, bin[10];

    for (i = 0; i < 10; i++){
        bin[i] = ((unsigned int)n >> i) & 1;
    }

    char binDigit[2];
    for(short j = 0, i = 9; j < 10; j++, i--){
        str[j] = (char) bin[i] + 48;
    }
}

void generateEntry(FILE* filePointer, int matrix[SAMPLES][4], int i, int j, int maxBit) {
    char str[11];
    //itoa(matrix[i][j], str, 2);
    printf("ENTERING FUNC...\n");
    intToBinary(matrix[i][j], str);
    char newStr[10];
    strcpy(newStr, "");

    printf("STR: %s\n", str);
    //printf("SIZE: %d\n", (strlen(str)));
    if(strlen(str) == maxBit) {
        printf("EQUAL\n");
        strcat(newStr, str);
    } else if (strlen(str) < maxBit) {
        printf("LESS\n");
        for(int i = 0; i < maxBit - strlen(str); i++){
            strcat(newStr, "0");
        }
        strcat(newStr, str);
    } else {
        printf("MORE\n");
        strcat(newStr, str + (strlen(str) - maxBit));
    }

    printf("NEW STR: %s\n", newStr);
    
    strcat(newStr, " ");
    fputs(newStr, filePointer);
}

void generateFile(char* fileName, int matrix[SAMPLES][4], int maxBit) {
    FILE* filePointer = fopen(fileName,"w");

	for (int i = 0; i < SAMPLES; i++) {
        //printf("%d\n", i);
        for (int j = 0; j < 4; j++) {
            //printf("%d\n", j);
            generateEntry(filePointer, matrix, i, j, maxBit);
        }
        if( i != SAMPLES - 1) fputs("\n", filePointer);
	}

	fclose(filePointer);
}

void generateEntryDec(FILE* filePointer, int matrix[SAMPLES][4], int i, int j) {
    char str[10];
    sprintf(str, "%d", matrix[i][j]);
    //itoa(matrix[i][j], str, 10);
    strcat(str, " ");
    fputs(str, filePointer);
}

void generateFileDec(char* fileName, int matrix[SAMPLES][4]) {
    FILE* filePointer = fopen(fileName,"w");

	for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < 4; j++) {
            printf("%d %d %d\n", i, j, matrix[i][j]);
            generateEntryDec(filePointer, matrix, i, j);
        }
        if( i != SAMPLES - 1) fputs("\n", filePointer);
	}

	fclose(filePointer);
}

int main(int argc, char const *argv[])
{
    int w[SAMPLES][64];
    int a[4];
    int s[SAMPLES][64];

    int x[SAMPLES][64];
    int y[SAMPLES][64];

    srand(time(NULL));

    for (int i = 0; i < SAMPLES; i++) {
        for (int j = 0; j < 64; j++) {
            x[i][j] = rand() % 256 - (rand() % 256);
        }
    }

    for(int i = 0; i < SAMPLES; i++) {
        //printf("%d\n", i);
        w[i][0] = rand() % 256 - (rand() % 256);
        w[i][1] = rand() % 256 - (rand() % 256);
        w[i][2] = rand() % 256 - (rand() % 256);
        w[i][3] = rand() % 256 - (rand() % 256);

        a[0] = w[i][0] + w[i][2];
        a[1] = w[i][1] + w[i][3];
        a[2] = w[i][0] - w[i][2];
        a[3] = w[i][1] - w[i][3];

        s[i][0] = (a[0] + a[1]); //>> 1;
        s[i][1] = (a[0] - a[1]); //>> 1;
        s[i][2] = (a[2] + a[3]); //>> 1;
        s[i][3] = (a[2] - a[3]); //>> 1;
    }

    generateFile("8x8_input.txt", w, 9);
    generateFile("8x8_output.txt", s, 17);

    generateFileDec("8x8_input_dec.txt", w);
    printf("OUT DEC...\n");
    generateFileDec("8x8_output_dec.txt", s);

    return 0;
}
