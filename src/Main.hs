import Data.List
import System.IO

main = do 
    putStrLn "What is your name?"
    name <- getLine 
    putStrLn ("Hey, " ++ name ++ ". Now how old are you exactly?")
    age <- getLine
    putStrLn("Ah perfect, so you are " ++ name ++ " and you are " ++ age ++ " years old")

-- Type decleration
addMe :: Int -> Int -> Int

--Function always goes like: 
addMe x y = x + y

addedValue = addMe 6 9

-- Adding tuples
addATuple :: (Int, Int) -> (Int, Int) -> (Int, Int)
addATuple (x, y) (x2, y2) = (x + x2, y + y2)

-- Perform actions based on input
whatAge :: Int -> String
whatAge 16 = "You are allowed to get your drivers license!"
whatAge 18 = "You can drink!"
whatAge 20 = "This is Ricardo's age as well!"
whatAge _ = "Sorry, there is nothing important for this"

-- Recursion time! a good example is factorial since we used that in the lesson too.
factorial :: Int -> Int

factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Simpler way to do this
prodFact n = product [1..n] -- Pass in n and take the product of that

-- Guards
isOdd :: Int -> Bool 
isOdd n 
    | n `mod` 2 == 0 = False -- If its even, return false
    | otherwise = True

whatGrade :: Int -> String
whatGrade n
    | (n == 10) && (n > 6) = "You aced the test!"
    | (n == 6) = "You barely passed, but still a good job!"
    | (n < 5) && (n >= 1) = "Try better next time!"
    | otherwise = "Try the test next time"

-- Using where
avgAttendanceRating :: Double -> Double -> String
avgAttendanceRating lessons notInClass
    | avg <= 0.550 = "Attend more classes!"
    | avg <= 0.750 = "Average attender"
    | avg <= 0.900 = "You're almost always there!"
    | otherwise = "Thank you for always being in class"
    where avg = (lessons - notInClass) / 100

-- Using a function to get items from a list
getListItems :: [Int] -> String
getListItems [] = "Your list is empty" 
getListItems (x:[]) = "Your list starts with " ++ show x 
getListItems (x:y:[]) = "Your list contains " ++ show x ++ " " ++ show y
getListItems(x:y:z:[]) = "Your first 3 items in the list are " ++ show x ++ " " ++ show y ++ " " ++ show z
getListItems(x:xs) = "The first items is " ++ show x ++ ". The rest of the items are " ++ show xs

getFirstItem :: String -> String

getFirstItem [] = "Empty String"
getFirstItem all@(x:xs) = "The first letter in " ++ all ++ " is " ++ [x]

-- Higher order functions
times10 :: Int -> Int
times10 x = x * 10

listTimes10 = map times10 [1, 2, 3, 4, 5]

-- Making our own map using recursion
multBy10 :: [Int] -> [Int]
multBy10 [] = []
multBy10 (x:xs) = times10 x : multBy10 xs 
-- First value x, 
-- times 10, and call the same function again with the rest of the items
-- That means the first value has changed!

--Checking again if strings are equal using recursion
areStringsEqual :: [Char] -> [Char] -> Bool
areStringsEqual [] [] = True
areStringsEqual (x:xs) (y:ys) = x == y && areStringsEqual xs ys
areStringsEqual _ _ = False

-- We expect a function to be passed (receive) inside a function using () decleration
doMult :: (Int -> Int) -> Int
doMult func = func 3
num3Times10 = doMult times10 -- Use the times 10 function 

-- We can also return functions from a function
getAddFunction :: Int -> (Int -> Int)

getAddFunction x y = x + y 
adds10 = getAddFunction 10
tenPlusTen = adds10 10

--Lambdas are defined using a backslash
dbl1To20 = map (\x -> x * 2) [1..20]

-- Using if clauses, if's always need elses in Haskell
doubleEvenNumber y = 
    if (y `mod` 2 /= 0)
        then y
        else y * 2
--Using case
getClass :: Int -> String
getClass n = case n of
    5 -> "Go to Kindergarten"
    6 -> "Go to elementary school"
    _ -> "Go away"
