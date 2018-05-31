{-# language OverloadedStrings #-}

module Main where

import Data.Functor (void)
import qualified Network.HTTP.Types.Status as Http
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.Wai as Wai
import System.Posix.Signals ( installHandler, Handler(Catch), sigTERM, fullSignalSet )

main :: IO ()
main = Warp.runSettings warpSettings $ \_req respond ->
         respond $ Wai.responseLBS Http.status200 [] "Hello World!"
  where
    warpSettings :: Warp.Settings
    warpSettings = Warp.setInstallShutdownHandler installShutdownHandler Warp.defaultSettings

    installShutdownHandler :: IO () -> IO ()
    installShutdownHandler closeSocket =
        void $ installHandler sigTERM (Catch handleTerm) (Just fullSignalSet)
      where
        handleTerm :: IO ()
        handleTerm = do
          putStrLn "Received SIGTERM. Closing socket..."
          closeSocket
          putStrLn "Socket closed."
