{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Nav where

import Import
import System.Directory
import Text.Julius (RawJS (..))
import System.FilePath
import Database.Persist.Sql

getStoryList :: Handler [(Int64,Text)]
getStoryList = runDB $ do
  storys :: [Entity Story] <- selectList [] []
  return $ map f storys
    where f = (\x -> (k x, i x))
          i = storyTitle . entityVal
          k = unSqlBackendKey . unStoryKey . entityKey
