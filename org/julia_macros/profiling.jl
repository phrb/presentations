function myfunc()
    A = rand(200, 200, 400)
    maximum(A)
end

myfunc() # run once to force compilation

using Profile

@profile myfunc()

Profile.print()

Profile.print(format = :flat, sortedby = :overhead)
