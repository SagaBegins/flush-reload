#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "probe.h"

//if there's any continuosly running background noise 
//this threshold will be reliably pick up accesses
const int THRESHOLD = 320;

//Only can be used when there isn't much noise picks up
//single uses quite reliably
const int UPPER_THRESHOLD = 350;

const float WAIT_SECONDS = 0.2f;
const int TO_MICROSECONDS = 1000000;

int main(){

    while(1){
        int t = reload((char*)placenum);

        if(t < UPPER_THRESHOLD){
            printf("Accessed %d\n", t);
        }
        // used for estimating the avg value missed when run with
        // and without ./test 1
        // else{
        //     printf("miss %d\n", t);
        // }
        
        flush(placenum);
        usleep(WAIT_SECONDS*TO_MICROSECONDS);
    }

    return 0;
}