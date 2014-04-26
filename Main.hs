{-# LANGUAGE OverloadedStrings #-}

module Main where
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Aeson
import Text.Printf
import Data.Maybe
import qualified Data.HashMap.Strict as M
import qualified Data.Vector as V
import Control.Lens
import Data.Aeson.Lens
import Data.Maybe
import Control.Monad 
import qualified Data.Text as T
import Control.Applicative

keys = ["user", "title", "comments"]


data Issue = Issue {
      title :: String
    , user :: String
    , labels :: [String]
    }  deriving (Show)

instance FromJSON Issue where
  parseJSON (Object v) = Issue <$>
      v .: "title" <*>
      (v .: "user" >>= (.: "login")) <*>
      ( (v .: "labels" >>= mapM (.: "name")) <|> (pure []) )

item v = 
  let user = T.unpack  $ v ^. ix "user" . ix "login" . _String
      title  = T.unpack . fromJust $ v ^? ix "title" ._String
      number  = fromJust $ v ^? ix "number" ._Integer
      comments  = fromJust $ v ^? ix "comments" . _Integer
      body  = T.unpack . fromJust $ v ^? ix "body" . _String
  in (user, number, title, comments, body)

main = do
  r <- BL.getContents
  let v = fromJust  $ (decode  r :: Maybe Value)
  let xs = map item (v ^.. _Array . traverse . _Object)
  mapM_ (\(u, n, t, c, _) -> 
      printf "%d\t%s\t%s\t%d\n" n u t c 
    ) xs

  let v' = (decode r :: Maybe [Issue])
  print v'
  

