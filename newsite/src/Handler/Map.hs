{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
module Handler.Map where

import           Import
import           Text.Julius (RawJS (..))
-- import           Text.Printf (printf)
-- import           System.IO

type Track = [Point]

getPoints :: Handler Track
getPoints = runDB $ do
    points <- selectList [ PointLong >. -85
                         , PointLong <. -47
                         , PointLat >. -56
                         , PointLat <. -0 ] []
    return $ map entityVal points

everyNth :: Int -> [a] -> [a]
everyNth n xs = case drop (n-1) xs of
                (y:ys) -> y : everyNth n ys
                []     -> []

-- Probably speed things up by saving the query
getMapR :: Handler Html
getMapR = do
  defaultLayout $ do
    setTitle "< 20 kmph: map"
    addScriptRemote
      "https://api.mapbox.com/mapbox-gl-js/v1.11.1/mapbox-gl.js"
    addStylesheetRemote
      "https://api.mapbox.com/mapbox-gl-js/v1.11.1/mapbox-gl.css"
    $(widgetFile "map")

-- points <- fmap (everyNth 25) getPoints
-- let pr = printf "%.3f"
-- let pss = map (\p -> [fromRational $ pointLong p, fromRational $ pointLat p])
--              points :: [[Float]]
-- let ps = map (map pr) pss :: [[String]] 
-- file <- liftIO $ openFile "static/paths/path.geojson" WriteMode
-- liftIO $ hPrint file ps
-- liftIO $ System.IO.hClose file
-- putStrLn $ pack $ show $ length points
