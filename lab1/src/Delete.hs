{-# LANGUAGE OverloadedStrings #-}

module Delete where

import           Database.MySQL.Base
import           Utils

class Delete a where
  deleteRow :: a -> [String] -> MySQLConn -> IO OK

instance Delete TableName where
  deleteRow Software params conn         = execute conn "DELETE FROM software WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Type params conn             = execute conn "DELETE FROM softwareType WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Author params conn           = execute conn "DELETE FROM author WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow User params conn            = execute conn "DELETE FROM user WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow TermOfUse params conn          = execute conn "DELETE FROM termOfUse WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow SoftwareAuthor params conn =
    execute
      conn
      "DELETE FROM softwareAuthor WHERE softwareId=? and authorId=?"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]
  deleteRow StatisticsOfUsage params conn =
    execute
      conn
      "DELETE FROM statisticsOfUsage WHERE softwareId=? and userId=?"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]

deleteRowManager :: TableName -> MySQLConn -> IO ()
deleteRowManager tableName conn = do
  case tableName of
    Software -> do
      putStrLn "Enter software id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Type -> do
      putStrLn "Enter type id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Author -> do
      putStrLn "Enter author id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    User -> do
      putStrLn "Enter user id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    TermOfUse -> do
      putStrLn "Enter use term id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    SoftwareAuthor -> do
      putStrLn "Enter software id: "
      field0 <- getLine
      putStrLn "Enter author id: "
      field1 <- getLine
      deleteRow tableName [field0, field1] conn
    StatisticsOfUsage -> do
      putStrLn "Enter software id: "
      field0 <- getLine
      putStrLn "Enter user id: "
      field1 <- getLine
      deleteRow tableName [field0, field1] conn
  putStrLn "Row(s) deleted"
