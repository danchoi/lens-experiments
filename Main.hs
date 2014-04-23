module Main where
import qualified Data.ByteString.Lazy.Char8 as BL

main = do
  r <- BL.getContents
  BL.putStrLn r

