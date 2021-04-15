{-# LANGUAGE OverloadedStrings #-}

module Update where

import           Data.List
import           Data.Text.Conversions
import           Database.MySQL.Base
import           Utils

class Update a where
  updateRow :: a -> String -> String -> String -> MySQLConn -> IO OK

instance Update TableName where
  updateRow Software "name" value index conn =
    execute conn "UPDATE software SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Software "annotation" value index conn =
    execute conn "UPDATE software SET annotation=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Software "version" value index conn =
    execute conn "UPDATE software SET version=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Type "name" value index conn =
    execute conn "UPDATE softwareType SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Author "name" value index conn =
    execute conn "UPDATE author SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Author "surname" value index conn =
    execute conn "UPDATE author SET surname=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow User "name" value index conn =
    execute conn "UPDATE user SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow User "surname" value index conn =
    execute conn "UPDATE user SET surname=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow User "login" value index conn =
    execute conn "UPDATE user SET login=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow TermOfUse "name" value index conn =
    execute conn "UPDATE termOfUse SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow TermOfUse "description" value index conn =
    execute conn "UPDATE termOfUse SET description=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]

updateRowManager :: String -> MySQLConn -> IO ()
updateRowManager name conn =
  case name of
    "softwareAuthor" -> putStrLn "This table can't be updated"
    "statisticsOfUsage" -> putStrLn "This table can't be updated"
    _ -> do
      putStrLn "Update where rowId =  "
      index <- getLine
      putStrLn "Enter column: "
      putStrLn (intercalate "\n" (updatableTableColumns name))
      field <- getLine
      if checkUpdatableColumns name field
        then do
          putStrLn "New value: "
          value <- getLine
          updateRow (getTableName name) field value index conn
          putStrLn "1 row updated"
        else putStrLn "ERROR - Invalid identifier"
