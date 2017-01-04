#!/usr/bin/env stack
-- stack --resolver lts-7.14 --install-ghc runghc --package turtle

{-# LANGUAGE OverloadedStrings #-}
import Turtle
import System.Environment
import Data.Maybe (fromMaybe)
import Control.Monad.IO.Class (liftIO)

site opt = ["exec", "site", opt ]

cmd name args = do
    x <- procStrict name args empty
    case x of
      (ExitSuccess, text) -> echo text
      (ExitFailure n, _)  -> die (name <> " failed with exit code: " <> repr n)

stack = cmd "stack"

git = cmd "git"

cmdName :: [String]
cmdName = [ "list"
          , "build"
          , "clean"
          , "deploy"
          , "rebuild"
          , "watch"
          ]

cmdFunc :: [IO ()]
cmdFunc = [ list
          , build
          , clean
          , deploy
          , rebuild
          , watch
          ]

dispatch :: [(String, IO ())]
dispatch = zip cmdName cmdFunc

main :: IO ()
main = do
    command <- getArgs
    fromMaybe (echo "Error") (lookup ( head command ) dispatch)

list :: IO ()
list = mapM_ putStrLn $ tail cmdName

build = stack ["build"]

clean = stack $ site "clean"

rebuild = stack $ site "rebuild"

watch = stack $ site "watch"

deploy = do
    -- build
    git ["checkout", "master"]
    build
    rebuild
    git ["checkout", "gh-pages"]

    cd "_site"
    sh(cmd "cp" ["-rf", ".", "../."])
    cd "../"

    -- commit
    git ["add", "."]
    git ["commit", "-m", "update"]
    git ["push"]
    git ["checkout", "master"]

