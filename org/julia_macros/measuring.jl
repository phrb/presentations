@elapsed a = rand(10 ^ 6)

@macroexpand @elapsed a = rand(10 ^ 6)

@allocated a = rand(10 ^ 6)

@macroexpand @allocated a = rand(10 ^ 6)

@time a = rand(10 ^ 6)

@macroexpand @time a = rand(10 ^ 6)

@timev a = rand(10 ^ 6)

@macroexpand @timev a = rand(10 ^ 6)
