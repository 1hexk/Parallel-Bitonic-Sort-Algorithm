#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <math.h>
#include <time.h>

#define ARRAY_SIZE 128
#define THREADS_PER_BLOCK 512

// Kernel for bitonic sort
__global__ void bitonic_sort(int* dev_array, int step, int stage) {
    // Thread index
    int tid = threadIdx.x + blockDim.x * blockIdx.x;
    // Length of the sub-sequence
    int sub_sequence_length = pow(2, step - stage + 1);
    // Skip for comparisons
    int jump = pow(2, step - stage);

    // Check if thread should participate in comparisons
    if (tid % sub_sequence_length < jump) {
        // If tid/2^step is even, sort ascendingly
        if ((tid / (int)pow(2, step)) % 2 == 0) {
            if (dev_array[tid] > dev_array[tid + jump]) {
                // Swap elements if needed
                int temp = dev_array[tid];
                dev_array[tid] = dev_array[tid + jump];
                dev_array[tid + jump] = temp;
            }
        }
        // If tid/2^step is odd, sort descendingly
        else {
            if (dev_array[tid] < dev_array[tid + jump]) {
                // Swap elements if needed
                int temp = dev_array[tid];
                dev_array[tid] = dev_array[tid + jump];
                dev_array[tid + jump] = temp;
            }
        }
    }
}

// Print an array with a title in a formatted manner
void printArray(const char* title, int* arr, int size) {
    // Print the title and the opening bracket
    printf("%s: [", title);

    // Iterate through the array elements
    for (int i = 0; i < size; i++) {
        // Add a comma before each element (except the first one)
        if (i != 0) {
            printf(", ");
        }

        // Print the array element
        printf("%d", arr[i]);
    }

    // Print the closing bracket and a newline character
    printf("]\n");
}

int main(void) {
    // Check if array size is a power of 2
    if (!(log2(ARRAY_SIZE) == (int)log2(ARRAY_SIZE))) {
        printf("Array size must be a power of 2 for Bitonic Sort!");
        return 0;
    }

    int host_array[ARRAY_SIZE];

    // Assign random numbers to each element in the array
    for (int i = 0; i < ARRAY_SIZE; i++) {
        host_array[i] = rand() % 300;
    }

    // Print unsorted array
    printArray("Random unsorted array", host_array, ARRAY_SIZE);


    // Define device array
    int* dev_array;
    int size = ARRAY_SIZE * sizeof(int);
    // Allocate memory on the device
    cudaMalloc(&dev_array, size);
    // Copy data from host to device
    cudaMemcpy(dev_array, host_array, size, cudaMemcpyHostToDevice);

    // Bitonic sort algorithm Steps
    for (int step = 1; step <= log2(ARRAY_SIZE); step += 1) {
        // Iterate through Stages
        for (int stage = 1; stage <= step; stage += 1) {
            // Call the bitonic_sort kernel
            bitonic_sort << <((ARRAY_SIZE + THREADS_PER_BLOCK - 1) / THREADS_PER_BLOCK), THREADS_PER_BLOCK >> > (dev_array, step, stage);
        }
    }

    // Copy sorted array back to host
    cudaMemcpy(host_array, dev_array, size, cudaMemcpyDeviceToHost);
    // Free device memory
    cudaFree(dev_array);

    // Print sorted array
    printArray("\nSorted array", host_array, ARRAY_SIZE);


    return 0;
}
