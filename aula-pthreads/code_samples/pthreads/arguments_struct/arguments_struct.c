#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#define NUM_THREADS 8

char *messages[NUM_THREADS];

struct thread_data{
    int	thread_id;
    int sum;
    char *message;
};

struct thread_data thread_data_array[NUM_THREADS];

void *print_hello(void *threadarg){
    int taskid, sum;
    char *hello_msg;
    struct thread_data *my_data;

    sleep(1);
    my_data   = (struct thread_data *) threadarg;
    taskid    = my_data->thread_id;
    sum       = my_data->sum;
    hello_msg = my_data->message;
    printf("Thread %d: %s \t Sum=%d\n", taskid, hello_msg, sum);

    int my_sum = sum;
    for(int i = 1; i < 100 * NUM_THREADS; i++) {
      my_sum *= i;
    }

    pthread_exit(NULL);
};

int main(int argc, char *argv[]){
    pthread_t threads[NUM_THREADS];
    int *taskids[NUM_THREADS];
    int error_code, t, sum;

    sum         = 0;
    messages[0] = "English: Hello World!";
    messages[1] = "French: Bonjour, le monde!";
    messages[2] = "Spanish: Hola al mundo";
    messages[3] = "Klingon: Nuq neH!";
    messages[4] = "German: Guten Tag, Welt!";
    messages[5] = "Russian: Zdravstvytye, mir!";
    messages[6] = "Japanese: Sekai e konnichiwa!";
    messages[7] = "Latin: Orbis, te saluto!";

    for(t = 0; t < NUM_THREADS; t++){
        sum                            = sum + t;
        thread_data_array[t].thread_id = t;
        thread_data_array[t].sum       = sum;
        thread_data_array[t].message   = messages[t];
        printf("Creating thread %d\n", t);
        error_code = pthread_create(&threads[t], NULL,
                                    print_hello, (void *) &thread_data_array[t]);
        if (error_code){
            printf("ERROR; return code from pthread_create() is %d\n", error_code);
            exit(-1);
        };
    };
    pthread_exit(NULL);
};
