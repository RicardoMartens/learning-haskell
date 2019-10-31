module IRC where

import System.IO
import System.Exit 
import qualified Network.Socket as N

-- My connection constants and authenticationtoken
serverHost = "irc.twitch.tv" :: String
myNick = "icenezzbot" :: String
myPort = 6667 :: N.PortNumber
myPass = "oauth:5bgiunromia4ytl8kfmoulz2fno5ka"  :: String
myChannel = "#icenezznl" :: String
myUserName = "IcenezzNL" :: String
twitchTvCommands = "twitch.tv/commands" :: String


-- Connecting to twitch using the host addres and socket, used information from 
-- https://wiki.haskell.org/Roll_your_own_IRC_bot to get started on this
-- Basically it first gets the host address which uses the port that is put in and the host address
-- Then it gets the socket of the host address, using the address, adding a socket type to it and adding the protocol to this address
-- then we connect to the socket using the host address, and handle the socket from Twitch
connectTo :: N.HostName -> N.PortNumber -> IO Handle
connectTo host port = do
    hostAddres : _ <- N.getAddrInfo Nothing (Just host) (Just (show port))
    hostSocket <- N.socket (N.addrFamily hostAddres) (N.addrSocketType hostAddres) (N.addrProtocol hostAddres)
    N.connect hostSocket (N.addrAddress hostAddres)
    N.socketToHandle hostSocket ReadWriteMode

-- Handles the beginning of the connection to the IRC 
handleConnection :: Handle -> IO ()
handleConnection h = do 
    write h "CAP REQ :" twitchTvCommands
    write h "PASS " $ myPass ++ "\r\n"
    write h "NICK " $ myNick ++ "\r\n"
    write h "JOIN " $ myChannel ++ "\r\n"

-- Writes data to the handler
write :: Handle -> String -> String -> IO ()
write h cmd args = do
    let msg = cmd ++ " " ++ args ++ "\r\n"
    hPutStr h msg
    putStr ("msg send is: " ++ msg)