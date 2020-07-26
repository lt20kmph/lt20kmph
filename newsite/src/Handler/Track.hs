{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
module Handler.Track where

import           Data.Aeson
import qualified Data.ByteString.Lazy as B
import           Data.List            ((!!))
import           Import
import           System.Directory     (listDirectory)

-- data Point = Point
--     { long :: Rational
--     , lat  :: Rational}
--     deriving (Show, Generic)

-- instance FromJSON Point
-- instance ToJSON Point

-- type Track = [Point]

p :: [Rational] -> Point
p rs = Point (rs!!0) (rs!!1)

getTrackR :: Handler Html
getTrackR = do
    let dir = "static/paths/"
    paths <- liftIO $ listDirectory dir
    bytes <- liftIO $ mapM (\x -> B.readFile (dir ++ x)) paths
    let j = map ((fromMaybe []) . (\x -> decode x :: Maybe [[Rational]])) bytes
    -- putStrLn $ pack $ show $ ((j!!0)!!0)
    -- _ <- mapM (mapM (runDB . insert . p)) j
    defaultLayout $ do
        setTitle "Tracks"
        $(widgetFile "stats")

