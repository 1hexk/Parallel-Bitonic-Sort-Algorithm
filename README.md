#   Bitonic Sort with CUDA

## Code Explanation

### Purpose

This code implements the Bitonic Sort algorithm using CUDA, a parallel computing platform developed by NVIDIA. CUDA enables efficient parallel processing on NVIDIA GPUs.

### Components

1.  **Kernel Function (`bitonic_sort`):**
    
    -   The core sorting logic is implemented in a CUDA kernel function (`bitonic_sort`) executed on the GPU.
    -   The kernel takes an array (`dev_array`) and two parameters (step and stage) to perform the bitonic sorting algorithm.
2.  **Helper Function (`printArray`):**
    
    -   A helper function (`printArray`) is defined to print an array in a formatted manner, aiding in displaying the random and sorted arrays.
3.  **Main Function (`main`):**
    
    -   The main function is the entry point of the program.
    -   It checks if the array size is a power of 2, printing an error message and exiting if not.
    -   A random unsorted array is generated and displayed.
    -   GPU memory is allocated, and the data is transferred from the host to the device.
    -   The bitonic sort kernel is executed on the GPU in a nested loop (for each step and stage).
    -   The sorted array is copied back to the host, and GPU memory is freed.
    -   The sorted array is printed, concluding the program.

### Error Handling

-   Checks if the array size is a power of 2.
-   Handles CUDA errors during memory allocation.

### Conclusion

The program provides a comprehensive implementation of the Bitonic Sort algorithm on the GPU using CUDA, demonstrating parallel sorting capabilities.

## Output Samples

### Array of size 8:

-   Random unsorted array: [11, 2, 4, 10, 14, 4, 3, 3]
-   Sorted array: [2, 3, 3, 4, 4, 10, 11, 14]

### Array of size 16:

-   Random unsorted array: [1, 7, 14, 0, 9, 4, 18, 18, 2, 4, 5, 5, 1, 7, 1, 11]
-   Sorted array: [0, 1, 1, 1, 2, 4, 4, 5, 5, 7, 7, 9, 11, 14, 18, 18]

### Array of size 32:

-   Random unsorted array: [9, 3, 30, 4, 1, 12, 22, 14, 18, 16, 9, 17, 17, 27, 9, 11, 19, 6, 27, 28, 7, 12, 30, 25, 4, 30, 13, 28, 6, 23, 7, 30]

-   Sorted array: [1, 3, 4, 4, 6, 6, 7, 7, 9, 9, 9, 11, 12, 12, 13, 14, 16, 17, 17, 18, 19, 22, 23, 25, 27, 27, 28, 28, 30, 30, 30, 30]

### Array of size 64:

-   Random unsorted array: [41, 35, 62, 4, 33, 44, 22, 46, 18, 16, 9, 49, 49, 59, 41, 43, 51, 38, 27, 60, 7, 12, 62, 25, 36, 30, 13, 28, 6, 55, 7, 30, 51, 18, 13, 8, 3, 59, 11, 38, 31, 3, 26, 61, 9, 56, 37, 31, 29, 20, 11, 60, 22, 53, 5, 59, 19, 13, 9, 10, 28, 27, 46, 50]

-   Sorted array: [3, 3, 4, 5, 6, 7, 7, 8, 9, 9, 9, 10, 11, 11, 12, 13, 13, 13, 16, 18, 18, 19, 20, 22, 22, 25, 26, 27, 27, 28, 28, 29, 30, 30, 31, 31, 33, 35, 36, 37, 38, 38, 41, 41, 43, 44, 46, 46, 49, 49, 50, 51, 51, 53, 55, 56, 59, 59, 59, 60, 60, 61, 62, 62]
