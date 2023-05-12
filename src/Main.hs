{-# LANGUAGE ForeignFunctionInterface #-}

module Main (main) where

import Foreign.C.Types

foreign import ccall "add" rsAdd :: CInt -> CInt -> CInt
foreign import ccall unsafe "say_hello" rsSayHello :: IO ()

helloRust :: IO ()
helloRust = do
    rsSayHello

    let theSum = rsAdd 1 2
    putStrLn $ "1 + 2 = " <> show theSum

main :: IO ()
main = putStrLn "Hello from Haskell!" *> helloRust
