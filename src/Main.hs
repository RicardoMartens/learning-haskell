import IRC
import Actions 
import System.IO
import qualified Network.Socket as N

-- Main method that makes connection to the twitch irc server
main :: IO ()
main = do 
    h <- connectTo serverHost myPort
    handleConnection h
    listen h 



