{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
module Settings.StaticFiles where

import Settings     (appStaticDir, compileTimeAppSettings)
import Yesod.Static (staticFilesList)

-- This generates easy references to files in the static directory at compile time,
-- giving you compile-time verification that referenced files exist.
-- Warning: any files added to your static directory during run-time can't be
-- accessed this way. You'll have to use their FilePath or URL to access them.
--
-- For example, to refer to @static/js/script.js@ via an identifier, you'd use:
--
--     js_script_js
--
-- If the identifier is not available, you may use:
--
--     StaticFile ["js", "script.js"] []
--

staticFilesList (appStaticDir compileTimeAppSettings) 
        [ "css/normalise.css",
          "paths/path.geojson",
          "marker_green.png",
          "marker_green_dark.png",
          "js/swiped-events-min.js",
          "js/lazy-pictures.js",
          "js/secrets.js",
          "pics/non_gallery/20/banner-1.jpg",
          "pics/non_gallery/20/banner-2.jpg",
          "pics/non_gallery/800/banner-1.jpg",
          "pics/non_gallery/800/banner-2.jpg",
          "pics/non_gallery/1500/banner-1.jpg",
          "pics/non_gallery/1500/banner-2.jpg"
          ]
