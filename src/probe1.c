#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "probe.h"
#include <string.h>

const int N = 500;
const float WAIT_SECONDS = 0.002f;
const int TO_MICROSECONDS = 1000000;

const char* START_TEST = "./test 1 &";
const char* END_TEST = "pgrep test | xargs kill";
const char* FILE_FORMAT = "data/%s/%s";
const char* SAVE_PLOTS = "python3 plotter.py";

/**
 * Probing a given pointer for N iterations and recording the 
 * time data into csv.
 * 
 * 
 * @param data A void* to the data to be probed
 * @param t An int array of size N to store the time calculated
 * @param name A char* used when writing to file
 */
void probe(char* data, int t[N],  char* save_path) {
    int total = 0;
    int temp = 0;

    for(int i = 0; i < N; ++i){
        temp = reload(data);

        t[i] = temp;
        total += t[i];

        flush(data);
        usleep(WAIT_SECONDS*TO_MICROSECONDS);
    }

    FILE *f = fopen(save_path, "w+");
    file_write(f, t);
    fclose(f);

    printf("Avg ticks: %d\n", total/N);
}

void file_write(FILE *f, int t[]) {

    if (f == NULL){
        printf("couldn't open file");
        exit(1);
    }
   
    for (int i=0; i<N; i++){
        fprintf(f,"%d, %d\n",i, t[i]);
    }   
}

int main(int argc, char** argv){

    int t[N];
    char buffer[50];
    char* test_machine; 

    if(argc == 1){
        printf("Please enter test machine Char(A, B, C or D)\n");
        exit(1);
    }else{
        test_machine = argv[1];
    }

    sprintf(buffer, FILE_FORMAT, test_machine, "notest/one.csv");
    printf("Probing One: ");
    probe(numbers[2], t, buffer);
    
    sprintf(buffer, FILE_FORMAT, test_machine, "notest/three.csv");
    printf("Probing Three: ");
    probe(numbers[4], t, buffer);

    sprintf(buffer, FILE_FORMAT, test_machine, "notest/six.csv");
    printf("Probing Six: ");
    probe(numbers[7], t, buffer);

    sprintf(buffer, FILE_FORMAT, test_machine, "notest/placenum.csv");   
    printf("Probing placenum: ");
    probe(placenum, t, buffer);

    system(START_TEST);
    printf("\nStarting measurments with test.\n");

    sprintf(buffer, FILE_FORMAT, test_machine, "testf/one.csv");
    printf("Probing One: ");
    probe(numbers[2], t, buffer);
    
    sprintf(buffer, FILE_FORMAT, test_machine, "testf/three.csv");
    printf("Probing Three: ");
    probe(numbers[4], t, buffer);

    sprintf(buffer, FILE_FORMAT, test_machine, "testf/six.csv");
    printf("Probing Six: ");
    probe(numbers[7], t, buffer);

    sprintf(buffer, FILE_FORMAT, test_machine, "testf/placenum.csv");   
    printf("Probing placenum: ");
    probe(placenum, t, buffer);

    system(END_TEST);
    printf("\nEnd of test\n");

    printf("\nStarting to save plots\n");
    system(SAVE_PLOTS);

    printf("Plots saved to ../results\n");

    return 0;
}