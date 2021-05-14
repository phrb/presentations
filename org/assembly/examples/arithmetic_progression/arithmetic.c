#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>

static int __attribute__ ((noinline))
arithmetic (int n)
{
  int i, sum = 0;
  for (i = 1; i < n; i++)
    sum += i;

  return sum;
}


/* Trivial.  */
static void
print_usage_message (void)
{
  fputs (
  "arithmetic: Compute sum from 1 to n.\n\n"
  "Usage: arithmetic <n>\n",
  stdout
  );
}

static bool
is_number (const char *str)
{
  while (*str != '\0')
    if (!isdigit (*str++))
      return false;

  return true;
}

int
main (int argc, char *argv[])
{
  int number;

  if (argc != 2)
    {
      /* Poucos parâmetros (ou demais?).  */
      print_usage_message ();
      return 1;
    }

  if (!is_number (argv[1]))
    {
      fprintf (stdout, "Error: %s is not a number!\n", argv[1]);
      return 1;
    }

  /* Converte string para inteiro.  */
  number = atoi (argv[1]);
  fprintf (stdout, "Arithmetic sum: %d\n", arithmetic (number));

  return 0;
}
