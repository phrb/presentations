prog = "1 + 1"

ex1 = Meta.parse(prog)
ex1

typeof(ex1)

ex1.head

ex1.args

ex2 = Expr(:call, :+, 1, 1)

ex1 == ex2

dump(ex2)

ex3 = Meta.parse("(4 + 4) / 2")

Meta.show_sexpr(ex3)
