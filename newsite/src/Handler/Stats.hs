{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Stats where

import Import

getStatsR :: Handler Html
getStatsR = do
    defaultLayout $ do
        setTitle "< 20 kmph: stats"
        addScript $ StaticR js_lazy_pictures_js
        $(widgetFile "stats")
