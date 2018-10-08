/* Code from https://www.thegeekstuff.com/2010/03/debug-c-program-using-gdb */

# include <stdio.h>

void fact(int i, int *j, int num)
{
  for (i=1; i<=num; i++)
    *j=*j*i;
}

int main()
{
  int i, j, num;
  printf ("Enter the number: ");
  scanf ("%d", &num );
  i = 1;

  fact(i, &j, num);
  printf("The factorial of %d is %d\n",num,j);
}
