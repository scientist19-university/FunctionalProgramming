{-# LANGUAGE OverloadedStrings #-}

module Create where

import           Data.List
import           Data.Text.Conversions
import           Database.MySQL.Base
import           Utils

class Create a where
  createRow :: a -> [String] -> MySQLConn -> IO OK

instance Create TableName where
  createRow Software params conn =
    execute
      conn
      "INSERT INTO software (name, annotation, version, downloadsCount, termOfUseId, typeId) VALUES(?,?,?,?,?,?)"
      [ MySQLText (toText (head params))
      , MySQLText (toText (params !! 1))
      , MySQLText (toText (params !! 2))
      , MySQLInt32 (toNum (params !! 3))
      , MySQLInt32 (toNum (params !! 4))
      , MySQLInt32 (toNum (params !! 5))
      ]
  createRow Type params conn = execute conn "INSERT INTO type (name) VALUES(?)" [MySQLText (toText (head params))]
  createRow Author params conn =
    execute
      conn
      "INSERT INTO author (name,surname) VALUES(?,?)"
      [MySQLText (toText (head params)), MySQLText (toText (params !! 1))]
  createRow User params conn =
    execute
      conn
      "INSERT INTO user (login, name, surname) VALUES(?,?,?)"
      [MySQLText (toText (head params)), MySQLText (toText (params !! 1)), MySQLText(toText (params !! 2))]
  createRow TermOfUse params conn =
    execute
      conn
      "INSERT INTO termOfUse (name, description) VALUES(?,?)"
      [MySQLText (toText (head params)), MySQLText (toText (params !! 1))]
  createRow SoftwareAuthor params conn =
    execute
      conn
      "INSERT INTO softwareAuthor (softwareId, authorId) VALUES(?,?)"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]
  createRow StatisticsOfUsage params conn =
    execute
      conn
      "INSERT INTO statisticsOfUsage (softwareId, userId, logonCount) VALUES(?,?,?)"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1)), MySQLInt32 (toNum (params !! 2))]

createRowManager :: TableName -> MySQLConn -> IO ()
createRowManager tableName conn = do
  putStrLn "Enter column values, delimiter - [enter]:"
  putStrLn (intercalate "\n" (tableColumns tableName))
  case tableName of
    Software -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      field3 <- getLine
      field4 <- getLine
      field5 <- getLine
      createRow tableName [field0, field1, field2, field3, field4, field5] conn
    Type -> do
      field0 <- getLine
      createRow tableName [field0] conn
    Author -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
    User -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      createRow tableName [field0, field1, field2] conn
    TermOfUse -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
    StatisticsOfUsage -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      createRow tableName [field0, field1, field2] conn
    SoftwareAuthor -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
  putStrLn "1 row inserted"
