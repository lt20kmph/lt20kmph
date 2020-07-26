{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NoImplicitPrelude     #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

module Handler.Gallery where

import           Basement.IntegralConv  (int64ToInt, intToInt64)
import           Data.List              (nub, (!!))
import qualified Data.List.NonEmpty     as N
-- import           Data.Time
import           Data.Time.Clock        (diffTimeToPicoseconds)
import           Data.Time.Format.Human (humanReadableTime)
import           Database.Persist.Sql
import           Import
import           System.Random          (mkStdGen, randomRs)
import           Text.HTML.TagSoup      (fromTagText, isTagText, parseTags)
import           Text.Julius            (RawJS (..))
import           Text.Read              (read)
import           Text.Blaze.Html

data PictureInfo = PictureInfo
    { picId     :: Text
    , fullSize  :: Route Static
    , bigSize   :: Route Static
    , medSize   :: Route Static
    , smallSize :: Route Static
    , tinySize  :: Route Static
    , caption   :: Text
    }

data GalleryInfo = GalleryInfo
    { galleryId    :: Int
    , galleryPics  :: [PictureInfo]
    , galleryTitle :: Html
    }

data StoryInfo = StoryInfo
    { storyId :: Int
    , title   :: Html
    , story   :: Text
    }

data CommentInfo = CommentInfo
    { name    :: Text
    , comment :: Text
    , time    :: Text
    }

getGalleryMainR :: Handler Html
getGalleryMainR = do
    storys <- getStoryList
    let p k = fmap (map (mkPictureInfo k)) $ getRandomPictures k
        f p (k,t) = p k >>= (\x -> return 
                                $ GalleryInfo k x (preEscapedToHtml t))
    galleryInfo <- mapM (f p) storys
    defaultLayout $ do
        setTitle "< 20 kmph: Gallery"
        addScript $ StaticR js_lazy_pictures_js 
        $(widgetFile "gallery-main")

mkPictureInfo :: GalleryId -> (Int,Text) -> PictureInfo
mkPictureInfo gid x =  PictureInfo ((pack . show . m . fst) x)
                                   (f "1500" x)
                                   (f "800" x)
                                   (f "400" x)
                                   (f "240" x)
                                   (f "20" x)
                                   (snd x)
  where f size x = StaticRoute ["pics",(pack $ show gid),
                                       (pack size),
                                       (pack (show $ fst x) ++ ".jpg")]
                                       []
        m x = x - 1

getGalleryR :: GalleryId -> Handler Html
getGalleryR gid = do
    unSortedPictures <- getPictures gid
    st               <- getStory gid
    let g (a1,_) (a2,_) = compare a1 a2
        pictures = sortBy g unSortedPictures
        galleryInfo = map (mkPictureInfo gid) pictures
        num = show $ length pictures
        textTags = map fromTagText $ filter isTagText $ parseTags $ story st
        nonEmptyTextTags = N.fromList textTags
        subtitle = N.head nonEmptyTextTags
        paragraphs = N.tail nonEmptyTextTags
    defaultLayout $ do
        addScript $ StaticR js_swiped_events_min_js 
        addScript $ StaticR js_lazy_pictures_js 
        setTitle $ toHtml $ title st
        $(widgetFile "gallery")

blankPage pc = [hamlet|
  $doctype 5
  <html>
      <head>
          <title>Comments
          <meta charset=utf-8>
          ^{pageHead pc}
      <body>
          ^{pageBody pc}|]

getCommentsR :: GalleryId -> PicId -> Handler Html
getCommentsR gid pid = do
  comments <- getComments gid pid
  pc <- widgetToPageContent $ do
    $(widgetFile "comments")
  withUrlRenderer $ blankPage pc

postCommentsR :: GalleryId -> PicId -> Handler Html
postCommentsR gid pid = do
  n <- lookupPostParam "new-name"
  c <- lookupPostParam "new-comment"
  case (n,c) of 
     (Just newName, Just newComment) -> runDB $ do
        p <- getPictureId gid pid
        t <- liftIO $ getCurrentTime
        insert $ Comment p newName newComment t
  comments <- getComments gid pid
  pc <- widgetToPageContent $ do $(widgetFile "comments")
  withUrlRenderer $ blankPage pc

getPictures :: GalleryId -> HandlerFor App [(Int,Text)]
getPictures gid = runDB $ do
  pictures <- rawSql "select ?? from picture where story_no=?"
                     [PersistInt64 $ intToInt64 gid]
  return $ map f pictures
      where f = (\x -> (j x, i x))
            j = picturePicNo . entityVal
            i = pictureCaption . entityVal

getStoryList :: HandlerFor App [(Int,Text)]
getStoryList = runDB $ do
  storys :: [Entity Story] <- selectList [] []
  -- putStrLn $ concat $ map (storyTitle . entityVal) storys
  return $ map f storys
    where f = (\x -> (k x, g x))
          g = storyTitle . entityVal
          k = int64ToInt . unSqlBackendKey . unStoryKey . entityKey

getStory :: GalleryId -> Handler StoryInfo
getStory gid = runDB $ do
  storys :: [Entity Story] <- selectList [] []
  let g = preEscapedToHtml . storyTitle . entityVal
      k = int64ToInt . unSqlBackendKey . unStoryKey . entityKey
      s = storyStory . entityVal
      f = (\x -> StoryInfo (k x) (g x) (s x))
      parsedStorys = map f storys
      story = (filter (\(StoryInfo x _ _) -> x == gid) parsedStorys)!!0
  return story

getRandomPictures :: GalleryId -> Handler [(Int,Text)]
-- getRandomPictures gid = do
--   pictures <- getPictures gid
--   p <- liftIO $ pick 4 pictures
--   return p
getRandomPictures gid = getPictures gid >>=
    (\x -> ((liftIO $ pick 4 x) >>= return))

getPictureId :: GalleryId -> PicId -> YesodDB App (Key Picture) 
getPictureId gid pid = do 
    picture <- rawSql "select ?? from picture where story_no=? and pic_no=?"
                        [ PersistInt64 $ intToInt64 gid
                        , PersistInt64 $ intToInt64 pid]
    let g (Entity id value) = id
    return $ (map g picture)!!0

getComments :: GalleryId -> PicId -> Handler [CommentInfo]
getComments gid pid = runDB $ do
    -- picture <- rawSql "select ?? from picture where story_no=? and pic_no=?"
    --                     [ PersistInt64 $ intToInt64 gid
    --                     , PersistInt64 $ intToInt64 pid]
    -- let g (Entity id value) = id
    -- let picId = (map g picture)!!0
    picId <- getPictureId gid pid
    let f c = (\a b d -> CommentInfo a b d)
                <$> (return $ commentName $ entityVal c)
                <*> (return $ commentComment $ entityVal c)
                <*> (fmap pack $ humanReadableTime $ commentTime $ entityVal c)
    selectList [CommentPicture ==. picId] [] >>= 
        (\x -> liftIO $ mapM f x) >>= return

pick :: Int -> [a] -> IO [a]
pick n xs = do
  t <- getCurrentTime
  let i = fromInteger $ diffTimeToPicoseconds $ (utctDayTime t)
      rs = randomRs (0,length xs - 1) (mkStdGen i) :: [Int]
      z = take n $ nub rs
  return $ map (xs!!) z
