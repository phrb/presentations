ex = :(a+b*c+1)

typeof(ex)

:(a + b*c + 1) ==
    Meta.parse("a + b*c + 1") ==
    Expr(:call, :+, :a, Expr(:call, :*, :b, :c), 1)

ex = quote
    x = 1
    y = 2
    x + y
end

typeof(ex)

:(1 + 2)

eval(ans)

ex = :(a + b)

eval(ex)

a = 1; b = 2;

eval(ex)

ex = :(x = 1)

x

eval(ex)

x

a = 1;

ex = Expr(:call, :+, a, :b)

a = 0; b = 2;

eval(ex)
