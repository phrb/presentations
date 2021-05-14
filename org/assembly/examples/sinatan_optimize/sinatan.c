#include <stdio.h>
#include <math.h>


/* Esse __attribute__ ((noinline)) serve para que o compilador não copie e cole
   essa função dentro de outra função.  Isso é uma otimização chamada de
   "inline", e normalmente é efetuada quando:

   * O código dentro da função é muito pequeno OU
   * A função é chamada em um único lugar

   Primeiro, pois há custo em chamar uma função (veja o exmplo do assembler),
   e o custo de empilhar/desempilhar o contexto pode ser muito alto quando
   comparado a o que ela faz.

   Segundo, pois se a função for grande, fazer várias cópias dela pelo
   programa aumenta muito o tamanho do binário, o que é indesejável pois
   aumenta o número de falhas de página e falhas no cache de instrução.

   Por que essa otimização é indesejável aqui?  Para não ter que ficar
   caçando o código inlinado no assembler :)

 */
static double __attribute__ ((noinline))
sinatan (double x)
{
  return sin (atan (x));
}

static void
print_usage_message (void)
{
  fputs (
  "Computes sin (atan (x)).\n"
  "Usage: sinatan <X>\n",
  stdout
  );
}

int
main (int argc, char *argv[])
{
  double x, y;

  if (argc != 2)
    {
      print_usage_message ();
      return 1;
    }

  sscanf (argv[1], "%lf", &x);
  y = sinatan (x);

  printf ("sin (atan (x)) = %lf\n", y);
  return 0;
}
