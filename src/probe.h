#include "libnumberpic.h"

//Array of addresses of the numbers stored in libnumberpic.h
extern const number_t* numbers[];

void access_data(char p) { return; } //Accessing the data

inline __attribute__((always_inline)) int reload(char* p){
    
    unsigned long t = 0;
    
    __asm__ volatile (
        "mfence\n"              // Serializing read and write instructions
        "rdtsc\n"               // Reading time stamp into rax
        "movl %%eax, %%esi\n"   // Copying time measured to esi
        "movl (%1), %%eax\n"    // Reading the data at p
        "mfence\n"              // Serializing read and write instructions
        "rdtsc\n"               // Reading time stamp
        "sub %%esi, %%eax\n"    // Calculating the time taken to read data at p 
        : "=a"(t)               // Output from rax to t
        : "c"(p)                // Input pointer p into rcx
        : "%esi", "%edx"        // Cobbering esi and edx
    );

    return t;
}

inline __attribute__((always_inline)) void flush(char* p){
    asm volatile("clflush 0(%0)\n":: "r"(p));  
}

