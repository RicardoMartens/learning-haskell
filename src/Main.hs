{-# LANGUAGE OverloadedStrings #-}  -- allows "string literals" to be Text

-- import Control.Monad (when)
-- import Data.Text (isPrefixOf, toLower, Text)
-- import Control.Concurrent (threadDelay)
-- import qualified Data.Text.IO as TIO

-- import Discord
-- import Discord.Types
-- import qualified Discord.Requests as R

-- main :: IO()
-- main = pingpongExample

-- -- | Replies "pong" to every message that starts with "ping"
-- pingpongExample :: IO ()
-- pingpongExample = do userFacingError <- runDiscord $ def
--                                             { discordToken = "NjM4MzQzNjQ0MjQzNTU4NDUx.XbbWmQ.tMdUld-otvsEmT1RmKrJBYiaX-c"
--                                             , discordOnEvent = eventHandler }
--                      TIO.putStrLn userFacingError

-- eventHandler :: DiscordHandle -> Event -> IO ()
-- eventHandler dis event = case event of
--        MessageCreate m -> when (not (fromBot m) && isPing (messageText m) && isBotChannel (messageChannel m)) $ do
--                _ <- restCall dis (R.CreateReaction (messageChannel m, messageId m) "eyes")
--                threadDelay (2 * 10^6) -- Wait 2 seconds
--                _ <- restCall dis (R.CreateMessage (messageChannel m) "Pong!")
--                pure ()
--        _ -> pure ()

-- fromBot :: Message -> Bool
-- fromBot m = userIsBot (messageAuthor m)

-- isPing :: Text -> Bool
-- isPing = ("ping" `isPrefixOf`) . toLower

-- isBotChannel :: Channel -> Bool
-- isBotChannel 

-- --(ChannelText _ _ "#haskell-bot" _ _ _ _) = True
             
import System.IO
import System.Exit 
import qualified Network.Socket as N
import Control.Exception
import Control.Monad (mapM_)
import Control.Monad.IO.Class
import Control.Monad.Trans.Reader
import Data.Text (isPrefixOf, toLower, Text, pack, unpack, splitOn)
import Data.List (intercalate)

serverHost = "irc.twitch.tv" :: String
myNick = "icenezzbot\r\n" :: String
myPort = 6667 :: N.PortNumber
myPass = "oauth:5bgiunromia4ytl8kfmoulz2fno5ka \r\n"  :: String
myChannel = "#icenezznl\r\n"
myUserName = "IcenezzNL"
twitchTvCommands = "twitch.tv/commands"

main :: IO ()
main = bracket connect disconnect loop
    where 
        disconnect = hClose . iceBotSocket
        loop state = runReaderT run state
    -- h <- connectTo serverHost myPort
    -- write h "PASS " myPass 
    -- write h "NICK " myNick
    -- write h "JOIN " myChannel
    -- listen h

data IceBot = IceBot { iceBotSocket :: Handle}
type Net = ReaderT IceBot IO

connect :: IO IceBot
connect = notify $ do
    h <- connectTo serverHost myPort
    return (IceBot h)
    where
        notify n = bracket_
         (putStrLn ("Connecting to " ++ serverHost ++ " ...") >> hFlush stdout)
         (putStrLn "done.")
         n

connectTo :: N.HostName -> N.PortNumber -> IO Handle
connectTo host port = do
    hostAddres : _ <- N.getAddrInfo Nothing (Just host) (Just (show port))
    hostSocket <- N.socket (N.addrFamily hostAddres) (N.addrSocketType hostAddres) (N.addrProtocol hostAddres)
    N.connect hostSocket (N.addrAddress hostAddres)
    N.socketToHandle hostSocket ReadWriteMode

run :: Net ()
run = do 
    write "CAP REQ :" twitchTvCommands
    write "PASS " myPass 
    write "NICK " myNick
    write "JOIN " myChannel
    listen


write :: String -> String -> Net ()
write cmd args = do
    h <- asks iceBotSocket
    let msg = cmd ++ " " ++ args ++ "\r\n"
    liftIO $ hPutStr h msg
    liftIO $ putStr ("> " ++ msg)

listen :: Net ()
listen = forever $ do
    h <- asks iceBotSocket
    line <- liftIO $ hGetLine h
    let cleanLine = init line
    liftIO (putStrLn $ clean cleanLine)
    liftIO (putStrLn $ getUsername cleanLine)
    if isPing cleanLine then pong cleanLine else evalStr (clean cleanLine)
    if (clean cleanLine) == "hey" then sendMsg (".w " ++ show (getUsername cleanLine) ++ " hey you bot maker!") else return()
    if (clean cleanLine) == "clean" then sendMsg (".clear") else return()
    where
        forever :: Net () -> Net ()
        forever a = do a; forever a 

        clean :: String -> String 
        clean = drop 1 . dropWhile (/= ':') . drop 1

        isPing :: String -> Bool
        isPing m = "PING" `isPrefixOf` pack m

        pong :: String -> Net ()
        pong m = write "PONG" (':' : drop 6 m)

evalStr :: String -> Net ()
evalStr "!quit" = write "QUIT" ":Exiting" >> liftIO exitSuccess
evalStr x | "!id " `isPrefixOf` pack x = sendMsg (drop 4 x)
evalStr _ = return()

sendMsg :: String -> Net ()
sendMsg s = write "PRIVMSG" (myChannel ++ " :" ++ s ++ "\r\n")

getUsername :: String -> String
getUsername = drop 1 . takeWhile(/= '!')