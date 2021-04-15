{-# LANGUAGE OverloadedStrings #-}

import           Create
import           Data.List
import           Database.MySQL.Base
import           Delete
import           FindById
import           ListAll
import           System.Exit
import           Update
import           Utils

main = do
  conn <-
    connect
      defaultConnectInfo
        {
          ciUser = "sql11404096",
          ciPassword = "wQiW6XSiyG",
          ciDatabase = "sql11404096",
          ciHost = "sql11.freemysqlhosting.net",
          ciPort = 3306
        }
  putStrLn "\nChoose table number:"
  putStrLn (unlines orderedTableNames)
  putStrLn "else exit\n"
  number <- getLine
  let name = numberToTableName number
  putStrLn ""
  if checkTableName name
    then do
      putStrLn
        "Choose operation:\nc - create\nu - update\nd - delete\nl - list all\nf - find by id\nelse - go back\n"
      x <- getLine
      putStrLn name
      case x of
        "c" -> createRowManager (getTableName name) conn
        "u" -> updateRowManager name conn
        "d" -> deleteRowManager (getTableName name) conn
        "l" -> listAllManager (getTableName name) conn
        "f" -> findByManager (getTableName name) conn
        _   -> putStrLn "Back"
    else do
      putStrLn "Exit"
      close conn
      exitSuccess
  close conn
  main
