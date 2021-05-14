#include <stdio.h>
#include <omp.h>
#define N           50
#define CHUNKSIZE   10

int main(int argc, char *argv[]){
    int i, chunk;
    float a[N], b[N], c[N];

    for (i = 0; i < N; i++){
        a[i] = b[i] = i * 1.0;
    };
    chunk = CHUNKSIZE;

    #pragma omp parallel for              \
        shared(a, b, c, chunk) private(i) \
        schedule(static, chunk)
    for(i = N - 1; i >= 0; i--){
        c[i] = a[i] + b[i];
    };

    #pragma omp parallel for
    for(i = 0; i < N; i++){
        printf("c[%d] = %f\n", i, c[i]);
    };

    return 0;
};
