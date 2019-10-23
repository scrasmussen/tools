
subroutine a()
  implicit none
  integer :: i,n

  do i=0,10000
    n = i+2
  end do
end subroutine a

subroutine b(x)
  implicit none
  integer, intent(INOUT) :: x
  x = 43 * 3
end subroutine b


program tau_test
  implicit none
  integer :: i,x
  x = 2

  do i=0,10000
    call a()
    call b(x)
  end do

  print *, "FIN"
end program tau_test
