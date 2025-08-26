#include <stdio.h>
#include <stdint.h>
#include <cuda_runtime.h>

#define N 1000000
#define THREADS_PER_BLOCK 256

__device__ void collatz(uint64_t x, uint64_t* steps, uint64_t* peak) {
    uint64_t n = x;
    *steps = 0;
    *peak = x;
    while (n != 1) {
        if (n & 1) {
            n = 3 * n + 1;
        } else {
            n >>= 1;
        }
        if (n > *peak) *peak = n;
        (*steps)++;
    }
}

__global__ void collatz_kernel(uint64_t* steps_arr, uint64_t* peak_arr) {
    uint64_t idx = blockIdx.x * blockDim.x + threadIdx.x + 1;
    if (idx <= N) {
        uint64_t steps, peak;
        collatz(idx, &steps, &peak);
        steps_arr[idx - 1] = steps;
        peak_arr[idx - 1] = peak;
    }
}

int main() {
    printf("hello world!\n");

    uint64_t *steps_arr, *peak_arr;
    uint64_t *d_steps_arr, *d_peak_arr;
    size_t size = N * sizeof(uint64_t);

    steps_arr = (uint64_t*)malloc(size);
    peak_arr = (uint64_t*)malloc(size);
    cudaError_t err;

    err = cudaMalloc(&d_steps_arr, size);
    if (err != cudaSuccess) { printf("cudaMalloc d_steps_arr error: %s\n", cudaGetErrorString(err)); return 1; }
    err = cudaMalloc(&d_peak_arr, size);
    if (err != cudaSuccess) { printf("cudaMalloc d_peak_arr error: %s\n", cudaGetErrorString(err)); return 1; }

    int blocks = (N + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK;
    collatz_kernel<<<blocks, THREADS_PER_BLOCK>>>(d_steps_arr, d_peak_arr);
    err = cudaGetLastError();
    if (err != cudaSuccess) { printf("Kernel launch error: %s\n", cudaGetErrorString(err)); return 1; }
    err = cudaDeviceSynchronize();
    if (err != cudaSuccess) { printf("cudaDeviceSynchronize error: %s\n", cudaGetErrorString(err)); return 1; }

    err = cudaMemcpy(steps_arr, d_steps_arr, size, cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) { printf("cudaMemcpy steps_arr error: %s\n", cudaGetErrorString(err)); return 1; }
    err = cudaMemcpy(peak_arr, d_peak_arr, size, cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) { printf("cudaMemcpy peak_arr error: %s\n", cudaGetErrorString(err)); return 1; }

    // Reduction on CPU for simplicity
    uint64_t best_n = 1, best_steps = 0, best_peak = 1, xor_steps = 0;
    for (uint64_t i = 0; i < N; ++i) {
        xor_steps ^= steps_arr[i];
        if (steps_arr[i] > best_steps) {
            best_steps = steps_arr[i];
            best_n = i + 1;
            best_peak = peak_arr[i];
        }
    }

    printf("collatz_longest(1..%d)\n", N);
    printf("n*=%llu\n", (unsigned long long)best_n);
    printf("steps=%llu\n", (unsigned long long)best_steps);
    printf("peak=%llu\n", (unsigned long long)best_peak);
    printf("xor_steps=%llu\n", (unsigned long long)xor_steps);

    cudaFree(d_steps_arr);
    cudaFree(d_peak_arr);
    free(steps_arr);
    free(peak_arr);
    return 0;
}
