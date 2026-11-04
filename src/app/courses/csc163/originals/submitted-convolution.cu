#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <wb.h>

#define MASK_WIDTH 5
#define O_TILE_WIDTH 16
#define MASK_RADIUS    (MASK_WIDTH / 2)
#define BLOCK_WIDTH    (O_TILE_WIDTH + MASK_WIDTH - 1)
#define clamp(x) (min(max((x), 0.0), 1.0))
#define CHANNELS 3


//@@ INSERT CODE HERE 
//implement the tiled 2D convolution kernel with adjustments for channels and make sure to:
//-use the constant memory for the convolution mask
//-use shared memory to reduce the number of global accesses and handle the boundary conditions when loading input list elements into the shared memory
//-clamp your output values

__global__ void conv2d_tiled(const float* __restrict__ input,float* output,int width, int height, int channels,const float* __restrict__ M) {

    // shared memory layout: [CHANNELS][BLOCK_WIDTH][BLOCK_WIDTH]
    __shared__ float shmem[CHANNELS][BLOCK_WIDTH][BLOCK_WIDTH];

    // global indices of the *output* pixel this thread will write
    int out_x = blockIdx.x * O_TILE_WIDTH + threadIdx.x;
    int out_y = blockIdx.y * O_TILE_WIDTH + threadIdx.y;

    // global indices of the *input* element this thread will load into shared mem
    // (includes halo)
    int in_x = blockIdx.x * O_TILE_WIDTH + threadIdx.x - MASK_RADIUS;
    int in_y = blockIdx.y * O_TILE_WIDTH + threadIdx.y - MASK_RADIUS;

    // for each of the 3 channels, load the corresponding value (or 0 if OOB)
#pragma unroll
    for (int c = 0; c < CHANNELS; ++c) {
        float val = 0.0f;
        if (in_x >= 0 && in_x < width && in_y >= 0 && in_y < height) {
            int gIdx = (in_y * width + in_x) * channels + c;
            val = input[gIdx];
        }
        shmem[c][threadIdx.y][threadIdx.x] = val;
    }

    __syncthreads();

    // Only threads whose (threadIdx.x, threadIdx.y) are inside the 16x16
    // output tile should write an output value.
    if (threadIdx.x < O_TILE_WIDTH && threadIdx.y < O_TILE_WIDTH &&
        out_x < width && out_y < height) {

        // compute 3 channels
#pragma unroll
        for (int c = 0; c < CHANNELS; ++c) {
            float accum = 0.0f;

            // 5x5 convolution
#pragma unroll
            for (int i = 0; i < MASK_WIDTH; ++i) {
#pragma unroll
                for (int j = 0; j < MASK_WIDTH; ++j) {
                    float pixel = shmem[c][threadIdx.y + i][threadIdx.x + j];
                    float coeff = M[i * MASK_WIDTH + j];
                    accum += pixel * coeff;
                }
            }

            // clamp to [0,1]
            accum = clamp(accum);

            // write back
            int outIdx = (out_y * width + out_x) * channels + c;
            output[outIdx] = accum;
        }
    }
}

int main(int argc, char *argv[]) {
  wbArg_t arg;
  int maskRows;
  int maskColumns;
  int imageChannels;
  int imageWidth;
  int imageHeight;
  char *inputImageFile;
  char *inputMaskFile;
  wbImage_t inputImage;
  wbImage_t outputImage;
  float *hostInputImageData;
  float *hostOutputImageData;
  float *hostMaskData;
  float *deviceInputImageData;
  float *deviceOutputImageData;
  float *deviceMaskData;

  arg = wbArg_read(argc, argv); /* parse the input arguments */

  inputImageFile = wbArg_getInputFile(arg, 0);
  inputMaskFile  = wbArg_getInputFile(arg, 1);

  inputImage   = wbImport(inputImageFile);
  hostMaskData = (float *)wbImport(inputMaskFile, &maskRows, &maskColumns);

  assert(maskRows == MASK_WIDTH);    /* mask height is fixed to 5 */
  assert(maskColumns == MASK_WIDTH); /* mask width is fixed to 5 */

  imageWidth    = wbImage_getWidth(inputImage);
  imageHeight   = wbImage_getHeight(inputImage);
  imageChannels = wbImage_getChannels(inputImage);

  outputImage = wbImage_new(imageWidth, imageHeight, imageChannels);

  hostInputImageData  = wbImage_getData(inputImage);
  hostOutputImageData = wbImage_getData(outputImage);

  size_t imageSize = imageWidth * imageHeight * imageChannels * sizeof(float);
  size_t maskSize = MASK_WIDTH * MASK_WIDTH * sizeof(float);

  wbTime_start(GPU, "Doing GPU Computation (memory + compute)");

  wbTime_start(GPU, "Doing GPU memory allocation");
  //@@ INSERT CODE HERE
  //allocate device memory
  cudaMalloc((void**)&deviceInputImageData, imageSize);
  cudaMalloc((void**)&deviceOutputImageData, imageSize);
  cudaMalloc((void**)&deviceMaskData, maskSize);

  wbTime_stop(GPU, "Doing GPU memory allocation");

  wbTime_start(Copy, "Copying data to the GPU");
  //@@ INSERT CODE HERE
  //copy host memory to device

  cudaMemcpy(deviceInputImageData,
      hostInputImageData,
      imageSize,
      cudaMemcpyHostToDevice);

  cudaMemcpy(deviceMaskData,
      hostMaskData,
      maskSize,
      cudaMemcpyHostToDevice);

  wbTime_stop(Copy, "Copying data to the GPU");

  wbTime_start(Compute, "Doing the computation on the GPU");
  //@@ INSERT CODE HERE
  //initialize thread block and kernel grid dimensions
  //invoke CUDA kernel	
  dim3 dimBlock(BLOCK_WIDTH, BLOCK_WIDTH, 1);
  dim3 dimGrid((imageWidth + O_TILE_WIDTH - 1) / O_TILE_WIDTH,
      (imageHeight + O_TILE_WIDTH - 1) / O_TILE_WIDTH,
      1);

  // invoke CUDA kernel
  conv2d_tiled <<<dimGrid, dimBlock >>> (deviceInputImageData,deviceOutputImageData,imageWidth,imageHeight,imageChannels,deviceMaskData);
  cudaDeviceSynchronize();

  wbTime_stop(Compute, "Doing the computation on the GPU");

  wbTime_start(Copy, "Copying data from the GPU");
  //@@ INSERT CODE HERE
  //copy results from device to host	
  cudaMemcpy(hostOutputImageData,
      deviceOutputImageData,
      imageSize,
      cudaMemcpyDeviceToHost);

  wbTime_stop(Copy, "Copying data from the GPU");

  wbTime_stop(GPU, "Doing GPU Computation (memory + compute)");

  wbSolution(arg, outputImage);

  //@@ INSERT CODE HERE
  //deallocate device memory
  cudaFree(deviceInputImageData);
  cudaFree(deviceOutputImageData);
  cudaFree(deviceMaskData);

  free(hostMaskData);
  wbImage_delete(outputImage);
  wbImage_delete(inputImage);

  return 0;
}
