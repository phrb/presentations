#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUM_THREADS 16

void *print_hello(void *threadid){
    long tid;
    tid = (long) threadid;
    printf("Hello World! It's me, thread #%ld!\n", tid);
    pthread_exit(NULL);
};

int main(int argc, char *argv[]){
    pthread_t threads[NUM_THREADS];
    int error_code;
    long t;
    for(t = 0; t < NUM_THREADS; t++){
        printf("In main: creating thread %ld\n", t);
        error_code = pthread_create(&threads[t], NULL,
                                    print_hello, (void *) t);
        if (error_code){
            printf("ERROR; return code from pthread_create() is %d\n", error_code);
            exit(-1);
        };
    };
    pthread_exit(NULL);
};
