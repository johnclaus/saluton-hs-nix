{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

main :: IO ()
main = scotty 80 $ notFound $ html "Saluton, mondo!"
