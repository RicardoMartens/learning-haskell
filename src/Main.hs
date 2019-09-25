import Data.List
import System.IO
--This is a comment!
{-
This is a multiline
comment!:)
-}
-- Finding out max and min int values: minInt = minBound :: Int results into -9223372036854775808
main = putStrLn "Hello, Haskell! I am new to this so please be nice to me! :)"

--minInt = minBound :: Int
-- bigFloat = 3.999999999999 + 0.000000000005 using a Double
amITwenty = True

-- Tuples can hold a list of many datatypes
-- Assigning a value to a constant of type Integer
stay20Forever :: Int
stay20Forever = 20;

-- math function to sum 1 through 99
sumOfNums = sum [1..99]

myMultiplication = 8 * 10

-- 5 % 4 = 1 making use of prefix operator
modEx = mod 5 4
-- An other way to do it using infix operator
modEx2 = 5 `mod` 4

num16 = 16 :: Int 

--Converting from a Integer to a float, we can use fromIntegral
sqrtOf16 = sqrt (fromIntegral num16)

-- Haskell is able to use tons of math functions
piValue = pi
ePow9 = exp 9
-- Using squared 
mySquaredValue = 5 ** 3

-- Truncate values down 
truncated9 = truncate 9.482
round8 = round 7.900
ceiling16 = ceiling 15.001
floor10 = floor 10.900

-- Booleans
trueAndFalse = True && False
trueOrFalse = True || False
notFalse = not(False)

-- Haskell uses single-linked lists
primeNumbers = [3, 5, 7, 11]
-- ++ here means a concatenation
morePrime = primeNumbers ++ [13, 17, 19, 23, 29]
-- Cons operator to construct a list
favNums = 1 : 3 : 3 : 7 :[]

multiList = [[3, 3, 7, 1, 2, 4],[9, 3, 2, 8, 1]]

morePrimesToMultiList = multiList ++ [[6, 2, 1, 6, 2], [19, 21, 56]]
morePrimes2 = 2 : morePrime

-- length of a list
lenOfMorePrime = length morePrimes2
lenOfThisMassivePrimeList = length morePrimesToMultiList -- is 4 cause 4 lists