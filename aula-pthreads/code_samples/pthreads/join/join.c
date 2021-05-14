#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define NUM_THREADS 8

void *do_work(void *t){
    int i;
    long tid;
    double result = 0.0;
    tid           = (long)t;
    printf("Thread %ld starting...\n",tid);

    for (i = 0; i < 1000000; i++){
        result = result + sin(i) * tan(i);
    };
    printf("Thread %ld done. Result = %e\n", tid, result);
    pthread_exit((void*) t);
};

int main (int argc, char *argv[]){
    pthread_t thread[NUM_THREADS];
    pthread_attr_t attr;

    int error_code;
    long t;
    void *status;

    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    for(t = 0; t < NUM_THREADS; t++){
        printf("Main: creating thread %ld\n", t);
        error_code = pthread_create(&thread[t], &attr, do_work, (void *) t);
        if (error_code){
            printf("ERROR; return code from pthread_create() is %d\n", error_code);
            exit(-1);
        };
    };

    pthread_attr_destroy(&attr);

    for(t = 0; t < NUM_THREADS; t++){
        error_code = pthread_join(thread[t], &status);
        if (error_code){
            printf("ERROR; return code from pthread_join() is %d\n", error_code);
            exit(-1);
        };
        printf("Main: completed join with thread %ld having a status of %ld\n",
               t, (long) status);
    };

    printf("Main: program completed. Exiting.\n");
    pthread_exit(NULL);
};
