program test_mpi
  use mpi
  implicit none
  integer :: ierr, rank, size

  call MPI_Init(ierr)
  call MPI_Comm_size(MPI_COMM_WORLD, size, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, rank, ierr)
  call MPI_Finalize(ierr)

end program test_mpi
