# My Haskell Challenge

## Haskell breakdown
For the course ASD-APP its the task to learn a new programming language, and make it your own by coming up with a challenge. The challenge will be explained later on. First I'll tell a little bit about Haskell and what I know about it so far

A list of things to look out for are:
- Haskell is a functional programming language. Once a value is set, it will be set forever.
- Functions can be passed as a parameter to other functions.
- Recursions are used very often. (exactly what we've learned within the APP-course) 
- Haskell does not work with while-loops, for-loops or "technically" variables.
- Haskell instead uses constants.
- Haskell is lazy
- Haskell counters that by instead checking for errors whenever anyone compiles their code. This means that Haskell has a very strict compiler, meaning it's also safe.
- You are able to define filters for lists to lets say, only allow values that can be divided by 15 and add another filter that allows values that can be divided by 10.

What I found very interesting is that, since I like math a lot, Haskell is amazing for math. That made it also a major plus for choosing the language for me.

I found out that Haskell uses type inference, meaning the variable knows what type it is based on the value you store in it. I recall that PHP can also do this, where it doesn't mind to now know what type it is, but assign the value to it eitherway. So, for example, if I gave a variable the value 6, it would be an Integer. Adding on to that, Haskell is statically typed; Once you define a type, you're not able to switch it. PHP in this instance is not statically typed, but dynamically typed. This means that Haskell checks its types before the code is executed, but PHP checks the types of variables at runtime.

### GHCi
Running Haskell through the command line goes pretty easily. You first need to work with GHCi (Glasgow Haskell Compiler), the "i" standing for the interactive environment. 
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
minInt is an example of a constant where its value is being printed to the command line.

A thing the GHCi uses is being able to see what operators exactly do, if we were to do 
```
*Main> :t (+)
(+) :: Num a => a -> a -> a
```
We get to see how exactly the +-operator works. This means it takes 2 parameters (first a and second a) and puts out a result (the final a). This of course not only works on operators but we could use it even on our own functions or Haskells functions.

### Haskell Tool Stack
Stack is, [what it already points out on the website](https://docs.haskellstack.org/en/stable/README/), a cross-platform program for developing Haskell projects. The IDE I'm working in (Visual Studio Code) sometimes doesn't work that well with just using a plugin and running the project. Therefor I'm using Stack and a system called "Cabal". It also comes with a Stack.yaml file where you can specify your packages under:
```yaml
extra-deps:
-   acme-missiles-0.3
-   other-package-here-version
```
Stack manages your packages needed for your project, build your project, test it and can also benchmark it for you (I haven't looked at testing or benchmarking myself yet). But not only that, it also installs the GHC for you automatically. How can we use GHCi to run the project once installed using stack? Well here it is:
```
ghci main <--- runs the Main module hs file
*Main> main <----- run the main method where it connects to something in my case to the twitch IRC server
```

### Cabal
Now that I pointed out Cabal, let's talk also a little bit about that and what I learned. Cabal is used by Stack as a build system. Whereas Stack defines the concepts of a project, Cabal defines the concept of a package. 

You might think, why do you need 2 different kind of command-line programs? Well, Stack could use the package thats like this:
```yaml
extra-deps:
-   my-cool-package-0.1
```
but you are not telling stack to build my-cool-package-0.3, you are only saying that it should use version 0.1. This is why we need to add a line to our build-depends within a cabal file that goes like this:
```cabal
build-depends: my-cool-package
```
If we were to use Cabal and Stack using the command line, it would need both because in the yaml file we tell Stack what version to use and in the cabal file we tell Stack that we want to require my-cool-package package. To install packages using cabal, it works the exact same as Stack using:
```
cabal install <my-package-name>
```
Now, let me talk a bit about the challenge I'm going to do.

## The Challenge
For the challenge, I went out of my way into something I'm always interested in, bots. (I made one myself using Python a bit back for Twitch, a streaming service). I absolutely love the way you are able to interact with them and I read you can also do this with Haskell. I think it will be hard to use sockets in Haskell since I didn't get to learn about them so there will be a lot of time going into that. Also it will go a bit further than what I learned in my tutorials, but I want to give this a shot because I'm really interested in bots.

I think my challenge fits this paradigm very well. I'm quite sure this is because I have to construct the program in such a way where constants will be immutable, like ports/sockets, and using the immutable states of the sockets.

My challenge is: Make an IRC bot on Twitch that can handle commands and send messages in the chat when people say a certain word/phrase.

I didn't want to make this too difficult so I set few points that I want to achieve using MoSCoW. These go as followed:

| Functionality                                                   	| MoSCoW 	| Done               	|
|-----------------------------------------------------------------	|--------	|--------------------	|
| It can responds to commands such as hello or how are you        	| Must   	| ✅ 	|
| It can connect to the Twitch IRC and send messages in chat        | Must   	| ✅   |
| Can communicate with other bots                                 	| Should 	| ❎ 	|
| You can gain points using the bot                               	| Should   	| ❎ 	|



## A few issues
### The Challenge
When I first started off, I could grasp Haskell quite easily. I thought it was so easy that I would make a Twitter clone, but I think I went a bit too far in that. So, I had to adjust my challenge and make something I actually really enjoy and should be a bit easier to do: making bots. 

### Working on the challenge
I of course didn't expect to work with the normal mathmetical functions I was using in my own exercises from the tutorials I did for making an IRC bot. Therefor working on the challenge was a bit stressful, seeing as in the tutorials I used they didn't tell me anything about how to work with sockets or how to use the Network library. I tried using Google to find some YouTube videos that could explain it to me, but to no avail. Luckily there were two links that really explained sockets to me, which was the Haskell Wiki about [rolling your own IRC Bot](https://wiki.haskell.org/Roll_your_own_IRC_bot) and this chapter in [this book](http://book.realworldhaskell.org/read/sockets-and-syslog.html) I gave a read. It really gave me a lot of insights in the world of using sockets and addresses in Haskell. I was really glad I could finally make some progress on my challenge

### Finishing the Challenge
I encountered a lot of issues when working on the bot, but the learning experience all the way through it was worth it. Sadly, I wasn't able to implement all my shoulds and extra stuff such as gaining points when you stay in the channel for a certain amount or time, or being able to add more than 1 command to the bot (since I write it to a file, but couldnt get it to go inside of an array). I did search alternatives for this such as appending to a file and all that, but I couldn't get it to work, costing me also a lot of precious time. Eitherway, the things I did get implemented are as followed:

- When you send a message in chat such as "hey" "hello bot" and "do you like chess?" you get a reaction from the bot or even a whisper (I recommend creating an account on Twitch for that)
- There are commands that only work for staff in a chat such as "clean". This corresponding commands makes it able to clear an entire chat (which the bot can do)
- You are able to add a command using !addcommand [command]
- You are able to delete that command using !removecommand [command] (It doesn't actually remove the command sadly since I didn't find a way to go about that)
- Keep in mind that I was not able to make it so it would move on to the next line in the file, so only 1 command is possible of being added.

For me ending this blog, I would recommend you to go to my [conclusion](#conclusion)

## Little code examples
I thought, looking back at the list of things to look out for, to show some little code examples I already tried out in my own code and of course the things I learned from videos and websites plus comparing these to the language I already know like Java.
### Filtering
The first interesting thing to start of with was using filters. Here I made some examples using these filters inside of lists or in other ways.
```haskell
divisBy10and15 = [x | x <- [1..500], x `mod` 15 == 0, x `mod` 10 == 0]
listBiggerThan10 = filter (>10) morePrimes2
evensUpTo100 = takeWhile (<= 100) [1,2..]
```
What this does is it looks at x, makes a list of values 1 through 500 in a list, and store that in x **BUT** filter it to only allow values that can be divided by 15 or by 10. On top of that, we could also filter a list immediately to print out values only bigger than 10 as seen in the 2nd example. The 3rd example shows a sort of a while loop. Meaning while values are less than or equal to 100, keep putting values (people tend to call Haskell lazy because of it allowing infinity) into a list till it hits 101.

I found it very interesting to learn this because its basically putting if-loops inside of lists to tell the lists what should be added. In Java we mostly call an if statement telling that when it loops over it we should only add the values in here that can be divided by 15 or divided by 10. Overall I enjoy being able to define these filters in these kind of ways.

### Functions
Functions in Haskell aren't surprisingly hard. However there are some things about them. Functions that don't receive parameters are called definitions or a name. They also can't start with an uppercase letter cause thats only used for types in Haskell. I tried using functions for myself according to the tutorials. Ill give an example of how a function normally works.
```
myFuncName param1 param2 = operations (which is the returned value)
```
And here are some exercise examples:
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
I learned how to use a type declaration for a function so that it only allows ints, as seen in the first example. In the second example it would give us the input times 5 back without a type declaration, so Haskell figures this out for you. The third example would ask us what our name and age is and print that in the console. More examples will be in my commits.

In Java functions go a bit differently using parameters and saying if a function is either private, public or protected, what type it is and what parameters it has. However in Haskell we first tell what the type is that the function uses, so in this case, it expects 2 ints, and outputs an int. In Java we would need to do:
```java
private int addMe(int x, int y){
    return x + y;
}
```
Also like I pointed out a bit earlier, Haskell doesn't necessarily need a type declaration, Haskell can figure this out on its own. Maybe similar to this in Java is the use of Generics, where it can figure out what type it is.

#### Recursive function
Recursion is used very often in Haskell, so let me show a recursive function in Haskell:
```haskell
factorial :: Int -> Int
factorial 0 = 1 -- Stop condition
factorial n = n * factorial (n - 1) -- Otherwise keep multiplying down based on the input the user gave
```
A famous example, the factorial function. If we were to pass in 3, it would pass us as answer 6. Which makes sense, cause its multiplying 3 * 2, where it first goes down to 1 * factorial(0) which equals 1, then passed 1 to 2 * factorial(1) etc. Very interesting as well that in Java this almost works the same way. Using factorial 0 = 1 as the stop condition almost looks like this in Java.
```java
if(n == 1){
    return n;
}
else return n * factorial (n - 1);
```

#### Guards
I also learned that functions can use guards, these little things can be used as a sort of if-statement. So if we were to say: 
```haskell
isOdd :: Int -> Bool 
isOdd n 
    | n `mod` 2 == 0 = False -- If its even, return false
    | otherwise = True
```
The comment already says it, but it will return false if its even, otherwise it returns true. In Java we would basically use if-statements that would go like this:
```java
private int isOdd(int n){
    if(n % 2 == 0){
        return false;
    } else {
        return true;
    }
}
```
#### Where
Where can also be used inside functions. With this, we don't have to continously write a math equation for a constant, but define a math equation inside of itself. Here is an example:
```haskell
avgAttendanceRating :: Double -> Double -> String
avgAttendanceRating lessons notInClass
    | avg <= 0.550 = "Attend more classes!"
    | avg <= 0.750 = "Average attender"
    | avg <= 0.900 = "You're almost always there!"
    | otherwise = "Thank you for always being in class"
    where avg = (lessons - notInClass) / 100
```
Here we don't know what average is, until the last line of code where it calculates what average actually is. I'm not sure if I've seen this before in Java or any other language I tried, but it surely is an interesting way to assign constants inside of a function nontheless.
#### Using lists
If you wanted to get some items from a list, there is something for that. Let me show you another example I wrote:
```haskell
getListItems :: [Int] -> String
getListItems [] = "Your list is empty" 
getListItems (x:[]) = "Your list starts with " ++ show x 
getListItems (x:y:[]) = "Your list contains " ++ show x ++ " " ++ show y
getListItems(x:y:z:[]) = "Your first 3 items in the list are " ++ show x ++ " " ++ show y ++ " " ++ show z
getListItems(x:xs) = "The first items is " ++ show x ++ ". The rest of the items are " ++ show xs
```
The strings kind of speak for itself. So, if an empty list gets passed, it returns saying the list is empty. If we wanted the first element, we do x:[]. What show inside the string does, is parse values to a string. If we wanted the first 2 values we do x:y:[]. If we wanted the first value and the rest of the values, we can just use x:xs, where x is the first value and xs the rest. There is also a trick using all@
```haskell
getFirstItem all@(x:xs) = "The first letter in " ++ all ++ " is " ++ [x]
```
This does the exact same thing, but differently written; using all the values inside a list, and giving the first value.

Normally in Java we would have to write if-statements to get certain values, use functions inside of Java already or explicitely tell an array what value we want. This doesn't look the same to me though as in other programming language I've done and is a very unique way to handle this.

#### Receive and return functions
I learned it's also possible to receive and return functions to other functions. So let me give you another example:
```haskell
-- We expect a function to be passed (receive) inside a function using () declaration
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

I'm pretty sure we are able to use functions are parameters and even return functions. For the first example I wrote down, it could look like this in Java where it returns a function:
```java
private int times10 (int x){
    return x  * 10;
} 
private int doMult (){
    return times10(3);
}
```
For passing functions, I had to look up on how to do that. You would need to wrap a function within an interface and call that function. An example would look like this:
```java
public T passFunction(Callable<T> func) {
    return func.call();
}
```
#### If-statements
Even though they aren't used that much, they aren't that complicated. If-statements in Haskell always need an else. Here is a quick example: 
```haskell
-- Using if clauses, if's always need elses in Haskell
doubleEvenNumber y = 
    if (y `mod` 2 /= 0)
        then y
        else y * 2
```
As you may see /= is something weird right? Well in Haskell this means not equals to. Eitherway this function looks if the input is not equal to a division possible by 2. If thats correct, then it return the input, otherwise it doubles the value. 

Ofcourse we can do if-statements in Java, so I don't think I really need to point that out. However, what is interesting is that if-statements in Java don't need elses, Haskell does.

A different way of doing this is using the case-statement. 
```haskell
--Using case
getClass :: Int -> String
getClass n = case n of
    5 -> "Go to Kindergarten"
    6 -> "Go to elementary school"
    _ -> "Go to a different school"
```
If the number is 5, they need to go to Kindergarten, and so on. This kind of works like a switch statement in Java and looks really similar. Let me show you:
```java
switch(myNumber){
    case 5:
        System.out.println("Go to Kindergarten");
        break;
    case 6:
        System.out.println("Go to elementary school");
        break;
    default:
        System.out.println("Go to a different school");
}
```

### Types
I learned about types. Types almost look to me like classes, but they aren't (luckily). It's very interesting how easily they are made, so I'll put an some examples down in this chapter

#### Enumerated types
Works the same as enums in Java, here an example:
```haskell
data Person = Baby
            | Child
            | Teenager
            | Adult
            deriving Show
```
This little code block gives an example of what a person could be (4 choices). Deriving show means that we can use it as a String to print it to the console. In Java this would look like:
```java
enum Person {
  BABY,
  CHILD,
  TEENAGER,
  ADULT
}
```
I like the way it looks in Haskell using the guards, but Javas way of doing it looks more simplistic and of course uses less code. In either I would say its easily understandable from both perspectives.

If I were to use this type I would do this:
```haskell
ricardoMartens :: Person -> Bool
ricardoMartens Adult = True
ricardoIsAnAdult = print(ricardoMartens Adult)
```
And in Java it would look like this:
```java
Person ricardoMartens = Person.ADULT;
```
However as you can see, I can't immediately say that I'm true when I'm an adult. For that to happen I would need to write an if-statement. This is one of the major plusses in my opinion of Haskell where you can even define the data type and say it returns a boolean.
#### Custom types
I also learned to make some custom types, so lets say we wanted to make a custom type of a Student:
```haskell
data Student = Student String String String
    deriving Show 
```
This makes a custom student type, which expects 3 different Strings. We can now use it like this, using one of my fellow students:
```haskell
sanderBussink :: Student
sanderBussink = Student "Sander Bussink" "Yeetstreet 123" "Lives with his parents"
```
Then with the following function:
```haskell 
getStudentName :: Student -> String
getStudentName (Student n _ _) = n
```
We can get his name, the underscores are basically saying "don't use this value, we only care about the name".

In Java you would almost say this works like classes or looks like it. Well, I for one can say it does kind of look like classes but types are different in that aspect. Types also make a program look way smaller than if we had to implement a class Student. In Java we would need to write a class for this to happen with a constructor expecting 3 strings with getters and setters. In Haskell use of types only limits it to maybe 2/3 lines of code.

#### Polymorphic types
We learned about polymorphism with Java, but haskell has it too with its types. Let's say we wanted to make a shape (a circle and a rectangle). This goes as follows: 
```haskell
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
    deriving Show
```
We expect a circle to have 3 floats, an x, y and a radius. For a rectangle we expect it to have an x, y, x1 and y2. Now in Java to achieve polymorphism we would need to do this to achieve the same thing:
```java
class Circle extends Shape{}
class Rectangle extends Shape{}
```
In my opinion, 1-liners are certainly the way to go for me and Haskell does it pretty well with its types, the almost equavalent of this with classes uses way more code and extra files, which I don't like that much.

We can use normal mathmetical equations for these shapes to calculate areas for instance: 
```haskell 
area :: Shape -> Float
area (Circle _ _ r) = pi * r ^ 2
area (Rectangle x y x2 y2) = (abs $ x2 - x) * (abs $ y2 - y)
```
The dollar sign in here replaces a set of parenthesis, telling the compiler that the set, whats normally inside of parenthesis, goes first. But the code almost speaks for itself, for a circle we care about the radius and how it is calculated. For the rectangle we want absolute values between x, x2 and y and y2.

In Java we would most likely have issues with values not being filled in giving us null pointers or straight up errors if we were to make use of the underscore. The second thing for calculating the area, we would need to write a method in the Shape class that Circle and Rectangle would have to override and make their own implementation of it. This requires a lot of work and I like how Haskell uses types instead.

### I/O
Input and outputs are definetely fun to play around with, we can even write to files and read from them which is amazing and really easy! So let's try it with this example: 
```haskell 
-- File I/O's
writeToFile = do
    theFile <- openFile "test.txt" WriteMode
    hPutStrLn theFile $ "Random line of text, seeing if this can write to a file!"
    hClose theFile

readFromFile = do
    theFile <- openFile "test.txt" ReadMode
    contents <- hGetContents theFile
    putStrLn contents
    hClose theFile
```
Here we can write to a file and read from a file. First we write that our file has to be opened first and what mode we want to apply to it. Then we want to put a bit of text in the file which is the 2nd line. Then we want to close the file and move on. In the second example we read the information on a file, we gather the contents in a constant and print all the content out in the console. 

In Java we need to use the Java I/O package. An example to use it is with a FileReader and FileWriter. There are also other ways to go about this in Java. If we were to write to a file we could do this:
```java
try(FileWriter fileWriter = new FileWriter("Ricardo.home" + File.seperator + "mytestfile.txt")){
    fileWriter.write("this is my test text");
} catch (IOException e){
    System.out.println(e);
}
```

## Conclusion
With all this new experience I got, I can certainly say learning Haskell was a lot of fun. I did have to get used to functional programming though for a bit, since I still wanted to sometimes work a bit on the imperative way of programming. However learning a declerative programming way made me open my eyes to what is even possible in these kinds of languages. Like the massive amounts of recursion that you need to use or how safe Haskell for instance is with its types and that you can't just cast a value. I didn't even know it was remotely possible to even make an IRC bot with Haskell. Eitherway I'm glad I can put another programming language to my learned languages and I'm probably going to make extra add-ons to this bot in the future I feel like. 

Thank you for reading my blog! Like I pointed out already, it was a lot of fun and hopefully I could bring you on a fun experience with me, thank you for your time!

## Links I used to study and learn Haskell
- https://github.com/aquarial/discord-haskell/wiki/Creating-your-first-Bot
- https://github.com/aquarial/discord-haskell 
- https://wiki.haskell.org/Roll_your_own_IRC_bot 
- https://www.youtube.com/watch?v=02_H3LjqMr8 
- https://tryhaskell.org/ 
- https://www.howistart.org/posts/haskell/1/


### Installed cabals for challenge and studying
- Network (cabal install network)