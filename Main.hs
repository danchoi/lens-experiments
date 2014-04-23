{-# LANGUAGE OverloadedStrings #-}

module Main where
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Aeson
import Text.Printf
import Data.Maybe

keys = ["user", "title"]

-- folding function
f :: Value -> [Value] -> [Value]
f a b = a : b

main = do
  r <- BL.getContents
  let v = fromJust  $ (decode  r :: Maybe Value)
  print v
  let res = foldr f [] v
  print res

