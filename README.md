# My Haskell Challenge

## Haskell breakdown
For the course ASD-APP its the task to learn a new programming language, and make it your own by coming up with a challenge. The challenge will be explained later on. First I'll tell a little bit about Haskell and what I know about it so far

A list of things to look out for are:
- Haskell is a functional programming language. Once a value is set, it will be set forever.
- Functions can be passed as a parameter to other functions.
- Recursions are used very often. (exactly what we've learned within the APP-course!) 
- Haskell does not work with while-loops, for-loops or "technically" variables.
- Haskell instead uses constants.
- Haskell is also lazy (and sometimes, so are we 😉)
- Haskell counters that by instead checking for errors whenever anyone compiles their code. This means that Haskell has a very strict compiler, meaning it's also safe!
- You are able to define filters for lists to lets say, only allow values that can be divided by 15 and add another filter that allows values that can be divided by 10!

What I found very interesting is that, since I like math a lot, Haskell is amazing for math! That made it also a major plus for me.

I found out that Haskell uses type inference, meaning the variable knows what type it is based on the value you store in it. So, for example, if I gave a variable the value 6, it would be an Integer. Adding on to that, Haskell is statically typed; Once you define a type, you're not able to switch it.

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
This means it takes 2 parameters (first a and second a) and puts out a result (the final a). 

## Little code examples
I thought, looking back at the list of things to look out for, to show some little code examples I already tried out in my own code!
### Filtering
```haskell
divisBy10and15 = [x | x <- [1..500], x `mod` 15 == 0, x `mod` 10 == 0]
listBiggerThan10 = filter (>10) morePrimes2
evensUpTo100 = takeWhile (<= 100) [1,2..]
```
What this does is it looks at x, makes a list of values 1 through 500 in a list, and store that in x **BUT** filter it to only allow values that can be divided by 15 or by 10. On top of that, we could also filter a list immediately to print out values only bigger than 10 as seen in the 2nd example. The 3rd example shows a sort of a while loop. Meaning while values are less than or equal to 100, keep putting values (people tend to call Haskell lazy because of it allowing infinity) into a list till it hits 101

### Functions
Functions in Haskell aren't surprisingly hard! However there are some things about them. Functions that don't receive parameters are called definiations or a name. They also can't start with an uppercase letter They always go like this: 
```
myFuncName param1 param2 = operations (which is the returned value)
```
Some examples are:
```haskell
addMe :: Int -> Int -> Int 
addMe x y = x + y

multiplyBy5 x = x * 5

main = do 
    putStrLn "What is your name?"
    name <- getLine 
    putStrLn ("Hey, " ++ name ++ ". Now how old are you exactly?")
    age <- getLine
    putStrLn("Ah perfect, so you are " ++ name ++ " and you are " ++ age ++ " years old")
```
I learned how to use a type decleration for a function so that it only allows ints, as seen in the first example. In the second example it would give us the input times 5 back without a type decleration, so Haskell figures this out for you. The third example would ask us what our name and age is and print that in the console. More examples will be in my commits.

#### Recursive function
Like I pointed out before, recursion is used very often in Haskell, so let me show a recursive function in Haskell:
```haskell
factorial :: Int -> Int
factorial 0 = 1 -- Stop condition
factorial n = n * factorial (n - 1) -- Otherwise keep multiplying down based on the input the user gave
```
A famous example, the factorial function. If we were to pass in 3, it would pass us as answer 6. Which makes sense, cause its multiplying 3 * 2, where it first goes down to 1 * factorial(0) which equals 1, then passed 1 to 2 * factorial(1) etc.

#### Guards
I also learned that functions can use guards, these little things can be used as a sort of if-statement. So if we were to say: 
```haskell
isOdd :: Int -> Bool 
isOdd n 
    | n `mod` 2 == 0 = False -- If its even, return false
    | otherwise = True
```
The comment already says it, but it will return false if its even, otherwise it returns true. 

#### Where
Where can also be used inside functions. With this, we don't have to, let's say, continously write a math equation for something, but define a math equation inside of itself. Here is an example:
```haskell
avgAttendanceRating :: Double -> Double -> String
avgAttendanceRating lessons notInClass
    | avg <= 0.550 = "Attend more classes!"
    | avg <= 0.750 = "Average attender"
    | avg <= 0.900 = "You're almost always there!"
    | otherwise = "Thank you for always being in class"
    where avg = (lessons - notInClass) / 100
```
Here we don't know what average is, until the last line of code where it calculates what average actually is.
#### Using lists
If you wanted to get some items from a list, there is also something for that! It's quite cool if I do say so myself. Here, an example!
```haskell
getListItems :: [Int] -> String
getListItems [] = "Your list is empty" 
getListItems (x:[]) = "Your list starts with " ++ show x 
getListItems (x:y:[]) = "Your list contains " ++ show x ++ " " ++ show y
getListItems(x:y:z:[]) = "Your first 3 items in the list are " ++ show x ++ " " ++ show y ++ " " ++ show z
getListItems(x:xs) = "The first items is " ++ show x ++ ". The rest of the items are " ++ show xs
```
The strings kind of speak for itself. So, if an empty list gets passed, it returns saying the list is empty. If we wanted the first element, we do x:[]. What show inside the string does, is parse values to a string. If we wanted the first 2 values we do x:y:[]. If we wanted the first values and the rest of the values, we can just use x:xs, where x is the first value and xs the rest. There is also a little trick using all@
```haskell
getFirstItem all@(x:xs) = "The first letter in " ++ all ++ " is " ++ [x]
```
This does the exact same thing, but differently written. Using all the values inside a list, and giving the first value. 
#### Receive and return functions
I learned it's also possible to receive and return functions to other functions. So let me give you another example:
```haskell
-- We expect a function to be passed (receive) inside a function using () decleration
times10 :: Int -> Int
times10 x = x * 10
doMult :: (Int -> Int) -> Int
doMult func = func 3
num3Times10 = doMult times10 -- Use the times 10 function 

-- We can also return functions from a function
getAddFunction :: Int -> (Int -> Int)
getAddFunction x y = x + y 
adds10 = getAddFunction 10
tenPlusTen = adds10 10
```
The first example shows that *doMult* expects a function and return an Integer. 
We put the function in doMult with a 3. Then we name a constant and assign it the doMult function with the times10 function that does 10 * 3 and return 30.

In the second example we pass an Integer to a function and expect it to return a function. What tenPlusTen does is call adds10 10, and adds10 uses that 10 in getAddFunction to add 10 + the other 10 which return 20.

#### If-statements
Even though they aren't used that much, they aren't that complicated. If-statements in Haskells case always need an else. Here is a quick example: 
```haskell
-- Using if clauses, if's always need elses in Haskell
doubleEvenNumber y = 
    if (y `mod` 2 /= 0)
        then y
        else y * 2
```
On a quick sidenode, as you may see /= is something weird right? Well in Haskells case this means not equals to. Eitherway this function looks if the input is not equal to a division possible by 2. If thats correct, then it return the input, otherwise it doubles the value. 

A different way of doing this is using the case-statement. 
```haskell
--Using case
getClass :: Int -> String
getClass n = case n of
    5 -> "Go to Kindergarten"
    6 -> "Go to elementary school"
    _ -> "Go away"
```
This kind of works like a switch statement in Java. If the number is 5, they need to go to Kindergarten, and so on. Quite easy!
