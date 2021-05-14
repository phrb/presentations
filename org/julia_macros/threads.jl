Threads.nthreads()

a = zeros(12)

Threads.@threads for i = 1:12
    a[i] = Threads.threadid()
end
a

@macroexpand Threads.@threads for i = 1:12
    a[i] = Threads.threadid()
end

a = rand(10 ^ 6)

@timev begin
    for i = 1:length(a)
        a[i] = Threads.threadid()
    end
end

@timev begin
    Threads.@threads for i = 1:length(a)
        a[i] = Threads.threadid()
    end
end
