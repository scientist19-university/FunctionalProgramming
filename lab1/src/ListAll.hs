{-# LANGUAGE OverloadedStrings #-}

module ListAll where

import           Database.MySQL.Base
import qualified System.IO.Streams   as Streams
import           Utils

class ListAll a where
  listAll :: a -> MySQLConn -> IO ([ColumnDef], Streams.InputStream [MySQLValue])

instance ListAll TableName where
  listAll Software conn               = query_ conn "SELECT * FROM software"
  listAll Type conn                   = query_ conn "SELECT * FROM softwareType"
  listAll Author conn                 = query_ conn "SELECT * FROM author"
  listAll User conn                   = query_ conn "SELECT * FROM user"
  listAll TermOfUse conn              = query_ conn "SELECT * FROM termOfUse"
  listAll SoftwareAuthor conn         = query_ conn "SELECT * FROM softwareAuthor"
  listAll StatisticsOfUsage conn      = query_ conn "SELECT * FROM statisticsOfUsage"

listAllManager :: TableName -> MySQLConn -> IO ()
listAllManager tableName conn = do
  (defs, is) <- listAll tableName conn
  print ("id" : tableColumns tableName)
  mapM_ print =<< Streams.toList is
