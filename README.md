___
## Mohamed Anis @AnisBoudj  
## Vidya Sagar @sagabegins
___

# Section 1: Preparation
    
For the preparation, a probe.h file containing flush, reload and access_data functions was created. This will be 
used for the flush and reload side channel attacks that need to be done in the other sections. More information on the 
implementation is under probe.h. 

# Section 2: Basic Side Channel Probing

## a) Checking access times
To check the access times probe1.c was implemented using the probe.h implemented in the previous section. This is 
more preparation for the upcoming attack as it will give us more information on access times and selecting a proper 
threshold for future sections.
## b) Basic Side Channel 
Using the information obtained in 2a) a threshold was selected and placenum was being probed indefinitely to check 
if it was being accessed by the victim. This is indicated when the program prints accessed. Numerous tests were 
conducted with the misses being printed with and without test running to select a proper threshold when the average 
access time obtained in 2a) was not precise enough. Individual accesses were hard to pick up and running a simple 
indefinite loop of int being set to 1 seemed to reduce the overall time taken between memory loads. 

# Section 3: Advance Side Channel Probing 

## a) Digit Probing
In this part,the target was the numbers array, which has been probed for every number it contained, it resulted 
in discovering the numbers accessed by the victim process. 

## b) Enhanced Exfiltration from web form.
We enhanced 3a) function to take in a command line argument t which makes the program run for t seconds
or indefinitely if t <= 0. Random single accesses aren't picked up but it works somewhat reliably detects the numbers 
accessed in test when it is run in an infinite loop. 

# Code

### probe.h: Vidya Sagar

This file contains three functions  
- access_data(char p)
- reload(char* p)
- flush(char* p)

`access_data` takes the deferenced data from the pointer which makes the system read the contents located at the address _p_ is pointing towards. This helps us know if the data is present in the cache if the time taken to access it is 
relatively lower.

`reload` takes a pointer address that needs to be accessed and measures the time taken to access the data that _p_ is pointing to. In the assembly portion, mfence is used instead of cpuid to reduce the latency caused by forced serialization of all instructions. mfence serializes the load and store operations which precede it. 
    
`flush` takes a pointer to the address that needs to be flushed from memory.


### probe1.c: Mohamed Anis, Vidya Sagar

This file contains two functions
- probe(char* data, int t[N],  char* save_path) 
- file_write(FILE *f, int t[])

`probe` takes the address of the data that needs to be probed, an array to store the access time values and a character array of the file name in which the measurements are saved. The address of the data is being flushed and 
reloaded N number of times waiting WAIT_SECONDS(0.002s) time between successive flush and reload. 

`file_write` writes the access times measured in the probe function and writes it in a csv format to file.

In order to make measurement easier, it takes a command line argument A, B, C or D to know which machine the program 
is being run on to save the data being collected accordingly. Then runs the probe function of each of the data needs 
to be probed with and without test running. Finally invokes **plotter.py** to plot and save the graphs into the results 
folder.

Flush and reload is being used to determine whether the given data is being accessed as the data is being constantly 
flushed from memory, a lower loading time would determine the access of the data by the victim.

    * Needs data and it's subfolders to function properly. 


### test.c: Mohamed Anis, Vidya Sagar

Added an extra placenum function to write number 7 into test.png. Changed the sleep function to usleep for easier probing.


### probe2.c: Vidya Sagar

We measure the access time of the placenum function by calling the reload function,
then we flush it out of the cache.
We compare that value with the threshold (defined through running the code many times),if it is above it, then the 
placenum was not called by test, and therefore it's a cache miss.
Otherwise, it's been accessed and cached. 


### autoprobe.c: Mohamed Anis, Vidya Sagar

The threshold value is the minimum time required for a number to be cached.
In an infinite loop we monitor the web app waiting for a user to load some number.
    
in a nested loop we reload and flush the first number to the cache, then we 
compare the time of reloading with our threshold, if it is below, then it must have been accessed by the web process 
and it is a cache hit, otherwise, it's a cache miss.
every accessed digit will be stored in an array, which will be prompted at the end.

The program slept for `0.2` seconds to let the victim access the data which loads it into the cache.
it runs for every number in the _numbers_[] array.

### plotter.py: Mohamed Anis, Vidya Sagar

For every csv file in the data directory, a plot is created and saved to the 
corresponding file in the results directory.

### Makefile: Vidya Sagar

# Project Structure 
```
├── README.md
├── results
│   ├── graphA-notest.png
│   ├── graphA-test.png
│   ├── graphB-notest.png
│   ├── graphB-test.png
│   ├── graphC-notest.png
│   ├── graphC-test.png
│   ├── graphD-notest.png
│   └── graphD-test.png
└── src
    ├── data
    │   ├── A
    │   │   ├── notest
    │   │   └── testf
    │   ├── B
    │   │   ├── notest
    │   │   └── testf
    │   ├── C
    │   │   ├── notest
    │   │   └── testf
    │   └── D
    │       ├── notest
    │       └── testf
    ├── index.html
    ├── jquery-3.4.1.min.js
    ├── libnumberpic.c
    ├── libnumberpic.h
    ├── Makefile
    ├── plotter.py
    ├── probe1.c
    ├── probe2.c
    ├── probe.h
    ├── test.c
    └── web.c
```

Data folder must be created for probe1 to function properly.