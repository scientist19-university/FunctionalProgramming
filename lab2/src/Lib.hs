{-# LANGUAGE BlockArguments #-}
module Lib where

import           Control.Parallel.Strategies
import           System.Environment
import           Debug.Trace
import           Data.List


toNumbers :: String -> [Double]
toNumbers line = map read $ words line :: [Double]

normalize :: Int -> [Double] -> [Double]
normalize index vector = map (/ (vector !! index)) vector

multiply :: Double -> [Double] -> [Double]
multiply m = map (m *)

solveSlae :: [[Double]] -> [Double]
solveSlae slae =
  trace("Upper triangular form: " ++ show (gaussianElimination slae))
  reverse $ solveSlaeRecursive (reverse $ gaussianElimination slae) []

solveSlaeRecursive :: [[Double]] -> [Double] -> [Double]
solveSlaeRecursive [] _ = []
solveSlaeRecursive (row:rows) solutionComponents =
  trace("\nRow to be processed: " ++ show row ++
        "\nRows left: " ++ show rows ++
        "\nReady solution params: " ++ show solutionComponents)
  let row' = reverse row
      x0 = head row'
      coefs = tail row'
      res = x0 - sum (zipWith (*) solutionComponents coefs)
   in res : solveSlaeRecursive rows (solutionComponents ++ [res])

gaussianElimination :: [[Double]] -> [[Double]]
gaussianElimination slae = stepToUpperTriangularForm slae 0

stepToUpperTriangularForm :: [[Double]] -> Int -> [[Double]]
stepToUpperTriangularForm [] index = []
stepToUpperTriangularForm (curRow:rows) index =
  let normalized = normalize index curRow
   in normalized : stepToUpperTriangularForm (runEval (reduceCol rows index curRow)) (index + 1)

reduceCol :: [[Double]] -> Int -> [Double] -> Eval [[Double]]
reduceCol slae colIndex pivotRow =
  rseq $ parMap rpar (subtractAlignedPivotRow pivotRow colIndex) slae

subtractAlignedPivotRow :: [Double] -> Int -> [Double] -> [Double]
subtractAlignedPivotRow pivotRow currentAligningCol subtractFromRow =
  zipWith (-)
  subtractFromRow
  ((subtractFromRow !! currentAligningCol)
  `multiply`
  normalize currentAligningCol pivotRow)
