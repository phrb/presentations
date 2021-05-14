macro sayhello()
    return :( println("Hello, world!") )
end

@sayhello

macro sayhello(name)
    return :( println("Hello, ", $name) )
end

@sayhello "MAC110"

ex = macroexpand(Main, :(@sayhello("human")) )

@macroexpand @sayhello "human"

@macroexpand @macroexpand @sayhello "human"

macro twostep(arg)
    println("I execute at parse time. The argument is: ", arg)
    return :(println("I execute at runtime. The argument is: ", $arg))
end

ex = macroexpand(Main, :(@twostep :(1, 2, 3)) );

typeof(ex)

ex

eval(ex)
