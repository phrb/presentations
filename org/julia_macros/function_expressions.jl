function math_expr(op, op1, op2)
    expr = Expr(:call, op, op1, op2)
    return expr
end

ex = math_expr(:+, 1, Expr(:call, :*, 4, 5))

eval(ex)

function make_expr2(op, opr1, opr2)
    opr1f, opr2f = map(x -> isa(x, Number) ? 2*x : x, (opr1, opr2))
    retexpr = Expr(:call, op, opr1f, opr2f)
    return retexpr
end

make_expr2(:+, 1, 2)

ex = make_expr2(:+, 1, Expr(:call, :*, 5, 8))

eval(ex)
