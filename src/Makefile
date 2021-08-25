CFLAGS=-Wall

all: test web libnumberpic.so probe1 probe2 autoprobe dataFolder

web:  libnumberpic.so web.o
	gcc web.o -o web -L. -lnumberpic -L/opt/local/lib -Wl,-R,.

test: libnumberpic.so test.o
	gcc test.o -o test -L. -lnumberpic -L/opt/local/lib -Wl,-R,.

web.o: web.c libnumberpic.h
	gcc -c ${CFLAGS} -g web.c -o web.o -I/opt/local/include

test.o: test.c libnumberpic.h
	gcc -c ${CFLAGS} -g test.c -o test.o -I/opt/local/include

libnumberpic.so: libnumberpic.o
	gcc -shared libnumberpic.o -o libnumberpic.so -L/opt/local/lib -lpng

libnumberpic.o: libnumberpic.c libnumberpic.h
	gcc -fpic -c ${CFLAGS} libnumberpic.c -o libnumberpic.o -I/opt/local/include

probe1: libnumberpic.so probe1.o
	gcc probe1.o -o probe1 -L. -lnumberpic -L/opt/local/lib -Wl,-R,.

probe1.o: probe1.c probe.h libnumberpic.h
	gcc -c ${CFLAGS} probe1.c -o probe1.o -I/opt/local/include
	
probe2: libnumberpic.so probe2.o
	gcc probe2.o -o probe2 -L. -lnumberpic -L/opt/local/lib -Wl,-R,.

probe2.o: probe2.c probe.h libnumberpic.h
	gcc -c ${CFLAGS} probe2.c -o probe2.o -I/opt/local/include
	
autoprobe: libnumberpic.so autoprobe.o
	gcc autoprobe.o -o autoprobe -L. -lnumberpic -L/opt/local/lib -Wl,-R,.

autoprobe.o: autoprobe.c probe.h libnumberpic.h
	gcc -c ${CFLAGS} autoprobe.c -o autoprobe.o -I/opt/local/include

simple: simple.o 
	gcc simple.c 

run: probe1 probe2 data
	./probe1
	./probe2 

dataFolder:
	-$(shell if [ ! -d data ]; 			\
	then 								\
		mkdir -v data; 					\
	fi; 								\
	 for x in A B C D; do 				\
	 if [ ! -d data/$$x ]; then			\
	 mkdir -v data/$$x; 				\
	 fi; 								\
	 if [ ! -d data/$$x/notest ]; then	\
	 mkdir -v data/$$x/notest;			\
	 fi;								\
	 if [ ! -d data/$$x/testf ]; then 	\
	 mkdir -v data/$$x/testf; 			\
	 fi; 								\
	 done)

#Can be run with make t2
#If you cancel when you run using this, then run `pgrep test | xargs kill` to stop 
#./test from running in the background
t2: probe2 test 
	./test 1 &
	./probe2 
	pgrep test | xargs kill

clean:
	rm -f test test.o libnumberpic.o libnumberpic.so web.o autoprobe.o autoprobe web probe[1-2] probe[1-2].o simple

cleandata:
	rm -rf data