module Main where

import           Control.Exception
import           Lib

main = do
  file <- readFile "sample-data/sample-system-2.txt"
  let slae = map toNumbers $ lines file
  
  catch (print $ solveSlae slae) handler
  where
    handler :: SomeException -> IO ()
    handler ex = putStrLn "The equation has no solutions!"
