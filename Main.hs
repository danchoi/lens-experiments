module Main where
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Aeson
import Text.Printf

main = do
  r <- BL.getContents
  print $ (decode  r :: Maybe Value)

