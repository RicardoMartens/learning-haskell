{-# LANGUAGE OverloadedStrings #-}  -- This way it allows strings to be text

module Actions where

import IRC
import System.IO
import System.Exit 
import qualified Network.Socket as N
import Data.Text (isPrefixOf, pack)
import Control.Concurrent

-- Listener for the server, keeps looping to find new lines of information that appears
-- in the twitch chat. It gets every line that is outputted in the chat and handles actions
listen :: Handle -> IO ()
listen h = keepLooping $ do
    line <- hGetLine h 
    let initLine = init line
    let cleanLine = getCleanLine initLine
    putStrLn $ cleanLine
    handleCommandActions h cleanLine
    handleUserActions h initLine
    -- Classic ping pong example to see if it actually is connected
    if isPing cleanLine then pong cleanLine else evalStr h (cleanLine)
    where
        -- Recursion
        keepLooping :: IO () -> IO ()
        keepLooping a = do a; keepLooping a 
    
        -- If ping gets send
        isPing :: String -> Bool
        isPing m = "PING" `isPrefixOf` pack m
    
        -- It sends pong
        pong :: String -> IO ()
        pong m = write h "PONG" (':' : drop 6 m)
    
        -- Gets the cleanline of some random irc text that wasnt needed
        getCleanLine :: String -> String
        getCleanLine n = clean n

-- Cleans the whole IRC line that is being outputted for information we need
clean :: String -> String 
clean = drop 1 . dropWhile (/= ':') . drop 1

-- Evaluatues over a string to find commands for example
evalStr :: Handle -> String -> IO ()
evalStr h "!quit" = write h "QUIT" ":Exiting" >> exitSuccess
evalStr h x | "!removecommand" `isPrefixOf` pack x = removeCommand h x
            | "!addcommand " `isPrefixOf` pack x = addCommand h x
evalStr _ _ = return()

-- This handles all actions that have to do with a user being involved/being mentioned from the bot
handleUserActions :: Handle -> String -> IO ()
handleUserActions h s = do
    if (clean s) == "hey" then sendMsg h (".w " ++ (getUsername s) ++ " hey you bot maker!") else return()
    if (clean s) == "hello bot" then sendMsg h ("Hello " ++ getUsername s) else return()
    if (clean s) == "do you like chess?" then sendMsg h ("Yes " ++ (getUsername s) ++ " I very much like chess, want to play some time?") else return()

-- Handles other actions such as commands that are for admins/moderators that dont involve usernames or just fun commands
handleCommandActions :: Handle -> String -> IO ()
handleCommandActions h s = do 
    if (s) == "clean" 
        then do 
            sendMsg h (".clear") 
            sendMsg h ("Cleared the chat for you!")
        else return() -- Clears the chat 



-- This basically makes us able to send messages with the bot
sendMsg :: Handle -> String -> IO ()
sendMsg h s = write h "PRIVMSG" (myChannel ++ " :" ++ s ++ "\r\n")

-- Gets the username from a string (the irc string)
getUsername :: String -> String
getUsername = drop 1 . takeWhile(/= '!')

-- Functionality of adding a command to the bot which you want to use
addCommand :: Handle -> String -> IO ()
addCommand h s = do 
    let commandWordList = words s
    if length commandWordList >= 3 then sendMsg h ("Only use 1 word for a command, adding command denied") 
    else if length commandWordList == 2 
        then do
         let commandWord = getCommandWord commandWordList 
         sendMsg h $ "The command " ++ commandWord ++ " has been added!"
         writeToFile commandWord
    else return ()

-- Functionality of removing a command, I couldnt get to implementing it where it removes a file sadly
removeCommand :: Handle -> String -> IO ()
removeCommand h s = do 
    let commandWordList = words s
    let commandWord = getCommandWord commandWordList
    readFile <- openFile "mycommands.txt" ReadMode
    contents <- hGetContents readFile
    let myList = lines contents
    if findCommand commandWord myList then do 
        sendMsg h ("Found the command " ++ commandWord ++ " in the list, the deletion of this will be implemented in the future!") 
    else do
        hClose readFile
        return ()

writeToFile :: String -> IO ()
writeToFile command = do
    theFile <- openFile "mycommands.txt" WriteMode
    hPutStrLn theFile $ command
    hClose theFile

-- Finds a specific command from a list of strings
findCommand :: String -> [String] -> Bool 
findCommand s (x:xs) = if x == s then True else findCommand s xs
findCommand _ _ = False

-- Gets commands from a word (First element indicates it was a normal word after the command)
getCommandWord :: [String] -> String
getCommandWord s = s !! 1 -- This indicates get the first element from an array

-- Sadly I tried implementing a feature for adding points but it didnt work since I had to work with recursion
-- This way the program would be stuck waiting for 1 minute being unresponsive so I didnt have time to implement this
-- Eitherway, here was my try at it!

-- handlePoints :: Handle -> String -> IO ()
-- handlePoints h s = do 
--     let i = 0
--     let j = i 
--     let i = j + 1
--     t0 <- getCurrentTime
--     go t0
--     where go t1 = do
--           t <- getCurrentTime
--           if t >= 10`addUTCTime`t1
--            then do
--               sendMsg h ("You got a point " ++ getUsername s)
--               go t
--            else go t1
--     --threadDelay $ 10 * 10^6
--     --sendMsg h ("Congratulations " ++ (getUsername s) ++ " you now have " ++ show i ++ " points!")
