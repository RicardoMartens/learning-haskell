import Data.List
import System.IO
-- Haskell uses single-linked lists
primeNumbers = [3, 5, 7, 11]
-- ++ here means a concatenation
morePrime = primeNumbers ++ [13, 17, 19, 23, 29]

multiList = [[3, 3, 7, 1, 2, 4],[9, 3, 2, 8, 1]]

morePrimesToMultiList = multiList ++ [[6, 2, 1, 6, 2], [19, 21, 56]]
-- Append 2 in front of the list
morePrimes2 = 2 : morePrime

-- Get index value of a list
secondIndexOfPrimes = morePrimes2 !! 1
-- Because Haskell uses single-linked lists, there is a head and a last (first and last value)
firstValueFromList = head morePrimes2
lastValueFromList = last morePrimes2
-- Look if a value is in a list
is19InList = 19 `elem` morePrimes2
-- min and max value in a list
maxValue = maximum morePrimes2
minValue = minimum morePrimes2
-- To get the product of values in a list
productList = [5, 11, 13]
productValue = product productList

letterList = ['a', 'b'..'z']
onlyA = take 10 (repeat 'a')
onlyB = replicate 10 'b'
cycleList = take 10 (cycle [1,2,3,4,5])
-- Working with | operator
listTimes2 = [x * 2 | x <- [1..10]]
--Filtering on values only less than or equal to 75 that result from the multiplication
listTimes5 = [x * 5 | x <- [1..10], x * 5 <= 75]

divisBy10N15 = [x | x <- [1..500], x `mod` 15 == 0, x `mod` 10 == 0]
-- Different kind of filtering
listBiggerThan10 = filter (>10) morePrimes2
-- Sorting is quite easy, using just a sort function with a list behind it
-- We can also sum multiples of a list using a powerful function called zipWith
sumOfAllLists = zipWith (+) [1,2,3,4,5] [6,7,8,9,10]
-- A sort of while loop can be used for lists
evensUpTo100 = takeWhile (<= 100) [1,2..]
-- foldl does from left to right, foldr from right to left
multOfList = foldl (*) 1 [2,3,4,5]
-- List comprehension time!
pow3Fromlist = [3^n | n <- [1..10]]
multiplyATable = [[x * y | y <- [1..10]] | x <- [1..10], x <= 5]
-- Tuples time
randomTuple = (1, "Random Tuple")
tuplePair = ("Ricardo Martens", 20)
myName = fst tuplePair
myAge = snd tuplePair
meAndMyClassMates = ["Sander Bussink", "Geert Braakman", "Ricardo Martens"]
classMatesAddress = ["Secret lane 123", "Secret lane 456", "Leliestraat 17"]
coupledPair = zip meAndMyClassMates classMatesAddress
quadruple = getQuadruple 6

getQuadruple x = x * 4
