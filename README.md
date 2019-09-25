# My Haskell Challenge

## Haskell breakdown
For the course ASD-APP its the task to learn a new programming language, and make it your own by coming up with a challenge. The challenge will be explained later on. First I'll tell a little bit about Haskell and what I know about it so far

A list of things to look out for are:
- Haskell is a functional programming language. Once a value is set, it will be set forever.
- Functions can be passed as a parameter to other functions.
- Recursions are used very often. (exactly what we've learned within the APP-course!) 
- Haskell does not work with while-loops, for-loops or "technically" variables.
- Haskell instead uses constants.
- Haskell is also is lazy (and sometimes, so are we 😉)
- Haskell counters that by instead checking for errors whenever anyone compiles their code.

What I found very interesting is that, since I like math a lot, Haskell is amazing for math! That made it also a major plus for me.

I found out that Haskell uses type inference, meaning the variable knows what type it is based on the value you store it. So, for example, if I gave a variable the value 6, it would be an Integer. Adding on to that, Haskell is statically typed; Once you define a type, you're not able to switch it.

Running Haskell through the commandline goes pretty easily. You first need to work with GHCi (Glasgow Haskell Compiler). the "i" standing for the interactive environment. 
To be able to use GHCi, we follow this chain of commands.
```
ghci (launching ghci)
"GHCi, version 8.6.5: http://www.haskell.org/ghc/  :? for help"

Prelude> :l (Standing for load) main (file without the .hs part)
"[1 of 1] Compiling Main             ( main.hs, interpreted )
Ok, one module loaded."

*Main> :r (running the compiler)
"Ok, one module loaded."

*Main> minInt
-9223372036854775808
```
minInt is an example of a constant where it's value is being printed to the commandline.

A neat little thing the GHCi uses is being able to see what operators exactly do, if we were to do 
```
*Main> :t (+)
(+) :: Num a => a -> a -> a
```
We get to see how exactly the +-operator works
This means it takes 2 parameters (first a and second a) and puts out a result (the final a)