{-# LANGUAGE OverloadedStrings #-}

module FindById where

import           Database.MySQL.Base
import qualified System.IO.Streams   as Streams
import           Utils

class FindById a where
  findById :: a -> String -> MySQLConn -> IO ([ColumnDef], Streams.InputStream [MySQLValue])

instance FindById TableName where
  findById Software index conn               = query conn "SELECT * FROM software WHERE id=?" [MySQLInt32 (toNum index)]
  findById Type index conn                   = query conn "SELECT * FROM softwareType WHERE id=?" [MySQLInt32 (toNum index)]
  findById Author index conn                 = query conn "SELECT * FROM author WHERE id=?" [MySQLInt32 (toNum index)]
  findById User index conn                   = query conn "SELECT * FROM user WHERE id=?" [MySQLInt32 (toNum index)]
  findById TermOfUse index conn              = query conn "SELECT * FROM termOfUse WHERE id=?" [MySQLInt32 (toNum index)]
  findById SoftwareAuthor index conn         = query conn "SELECT * FROM softwareAuthor WHERE softwareId=?" [MySQLInt32 (toNum index)]
  findById StatisticsOfUsage index conn =
    query conn "SELECT * FROM statisticsOfUsage WHERE softwareId=?" [MySQLInt32 (toNum index)]

findByManager :: TableName -> MySQLConn -> IO ()
findByManager tableName conn = do
  putStrLn "Enter id: "
  index <- getLine
  (defs, is) <- findById tableName index conn
  print ("id" : tableColumns tableName)
  print =<< Streams.toList is
