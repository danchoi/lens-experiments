{-# LANGUAGE OverloadedStrings #-}

module Main where
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Aeson
import Text.Printf
import Data.Maybe
import qualified Data.HashMap.Strict as M
import qualified Data.Vector as V

keys = ["user", "title"]

-- folding function
f :: Value -> [Value] -> [Value]
f (Object o) acc = map f (M.toList o) ++ acc
f (Array a) acc = map f (V.toList a) ++ acc
f a b = a : b

main = do
  r <- BL.getContents
  let v = fromJust  $ (decode  r :: Maybe Value)
  print v
  let res = foldr f [] v
  print res

