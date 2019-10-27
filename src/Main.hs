-- These are modules!
import Data.List
import System.IO

-- Example to import functions from a file to
--module SampFunctions (getClass, doubleEvenNumbers) where 
--import SampFunctions -- To use it in our program

--Emumerated types
data Person = Baby 
            | Child 
            | Teenager 
            | Adult
            deriving Show

ricardoMartens :: Person -> Bool
ricardoMartens Adult = True
ricardoIsAnAdult = print(ricardoMartens Adult)

-- Custom types
data Student = Student String String String
-- Data student could also be data School = Teacher | Student | Classroom
    deriving Show 

sanderBussink :: Student
sanderBussink = Student "Sander Bussink" "Yeetstreet 123" "Lives with his parents"

getStudent :: Student -> String
getStudent (Student n _ _) = n

-- Polymorphic type
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
    deriving Show

area :: Shape -> Float

area (Circle _ _ r) = pi * r ^ 2
--area (Rectange x y x2 y2) = (abs (x2 - x)) * (abs (y2 - y))
-- Can use dollar signs to avoid parenthesis (Is used a lot!)
area (Rectangle x y x2 y2) = (abs $ x2 - x) * (abs $ y2 - y)

-- Using the . operator, it chains value together
--sumValue = putStrLn (show (1 + 2))
sumValue = putStrLn . show $ 1 + 2
areaOfCircle = area (Circle 50 60 20)
areaOfRect = area $ Rectangle 10 10 100 100

-- Type classes, are gonna correspond to sets of types which have certain operations defined for them
-- so if we did :t (+), for any value of a that is an instance of Num, we can add it!

-- Here an employee can be showed as a string, and checked for equality between them
data Employee = Employee { name :: String,
                           position :: String,
                           idNum :: Int
                         } deriving (Eq, Show)

ricardoMartens1 = Employee {name = "Ricardo Martens", position = "Student", idNum = 592584}     
ricardoMartens2 = Employee {name = "Ricardo Martens", position = "Manager", idNum = 592581}       

isRicardo1Ricardo2 = ricardoMartens1 == ricardoMartens2 -- Returns false
ricardoMartens1Data = show ricardoMartens1

data ShirtSize = S | M | L
-- Override Eq and Show methods
instance Eq ShirtSize where
    S == S = True
    M == M = True
    L == L = True
    _ == _ = False

instance Show ShirtSize where
    show S = "Small"
    show M = "Medium"
    show L = "Large"

-- Elem checks if something is in a list
smallAvail = S `elem` [S, M, L]
sizeOfShirt = show S

--Custom typeClass
class MyEq a where
    areEqual :: a -> a -> Bool

instance MyEq ShirtSize where
    areEqual S S = True
    areEqual M M = True
    areEqual L L = True
    areEqual _ _ = False
newSize = areEqual M M 

-- I/O's
tellMeHello = do
    putStrLn "Who are you? (Provide a name)"
    name <- getLine
    putStrLn $ "Hello " ++ name

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

-- Fibonacci Sequence!
fib = 1 : 1 : [a + b | (a, b) <- zip fib $ tail fib]
-- First sequence returns [1, 1, 2] cause first element was 1 and tail was 1, so 1 + 1 = 2
-- Second sequence returns [1, 1, 2, 3] the second 1 and the tail was 2, so 1 + 2 = 3
-- So on  and on, pretty cool!
fib5 = fib !! 5