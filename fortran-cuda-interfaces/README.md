From https://github.com/MentorEmbedded/fortran-cuda-interfaces

Set of Fortran interfaces to CUDA libraries for GCC/OpenACC.
Modules include cublas, cublas_v2, cublasxt, openacc_cublas, cufft.

cublas_core is an internal module of shared definitions used by some of the
above listed modules.


### To use
`$ make` to build modules.
Include modules with `-I/path/to/interface/modules`
Link to modules with `-L/cubasrc/lib64 -lCudaModuleName`