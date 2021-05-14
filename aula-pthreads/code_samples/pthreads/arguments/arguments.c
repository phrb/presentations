#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define NUM_THREADS	8

char *messages[NUM_THREADS];

void *print_hello(void *threadid){
    long taskid;

    sleep(1);
    taskid = (long) threadid;
    printf("Thread %d: %s\n", taskid, messages[taskid]);
    pthread_exit(NULL);
};

int main(int argc, char *argv[]){
    pthread_t threads[NUM_THREADS];
    long taskids[NUM_THREADS];
    int error_code, t;

    messages[0] = "English: Hello World!";
    messages[1] = "French: Bonjour, le monde!";
    messages[2] = "Spanish: Hola al mundo";
    messages[3] = "Klingon: Nuq neH!";
    messages[4] = "German: Guten Tag, Welt!";
    messages[5] = "Russian: Zdravstvuyte, mir!";
    messages[6] = "Japan: Sekai e konnichiwa!";
    messages[7] = "Latin: Orbis, te saluto!";

    for(t = 0; t < NUM_THREADS; t++){
        taskids[t] = t;
        printf("Creating thread %d\n", t);
        error_code = pthread_create(&threads[t], NULL, print_hello, (void *) taskids[t]);
        if (error_code){
            printf("ERROR; return code from pthread_create() is %d\n", error_code);
            exit(-1);
        };
    };
    pthread_exit(NULL);
};
