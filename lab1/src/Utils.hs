module Utils where

import           Data.Int
import           Data.Time

data TableName
  = Software
  | Type
  | Author
  | User
  | TermOfUse
  | SoftwareAuthor
  | StatisticsOfUsage

tableNames :: [String]
tableNames = ["software", "softwareType", "author", "user", "termOfUse", "softwareAuthor", "statisticsOfUsage"]

orderedTableNames :: [String]
orderedTableNames = ["1. software", "2. softwareType", "3. author", "4. user", "5. termOfUse", "6. softwareAuthor", "7. statisticsOfUsage"]

numberToTableName :: String -> String
numberToTableName "1" = "software"
numberToTableName "2" = "softwareType"
numberToTableName "3" = "author"
numberToTableName "4" = "user"
numberToTableName "5" = "termOfUse"
numberToTableName "6" = "softwareAuthor"
numberToTableName "7" = "statisticsOfUsage"
numberToTableName _   = "exit"

toNum :: String -> Int32
toNum str = fromInteger (read str :: Integer)

toDate :: String -> LocalTime
toDate dateStr = parseTimeOrError True defaultTimeLocale "%YYYY-%mm-%dd %H:%M" dateStr :: LocalTime

checkTableName :: String -> Bool
checkTableName name = name `elem` tableNames

tableColumns :: TableName -> [String]
tableColumns Software = ["name", "annotation", "version", "downloadsCount", "termOfUseId", "typeId"]
tableColumns Type = ["name"]
tableColumns Author = ["name", "surname"]
tableColumns User = ["login", "name", "surname"]
tableColumns TermOfUse = ["name", "description"]
tableColumns SoftwareAuthor = ["softwareId", "authorId"]
tableColumns StatisticsOfUsage = ["softwareId", "userId", "logonCount"]

updatableTableColumns :: String -> [String]
updatableTableColumns "software" = ["name", "annotation", "version"]
updatableTableColumns "softwareType" = ["name"]
updatableTableColumns "author" = ["name", "surname"]
updatableTableColumns "user" = ["login", "name", "surname"]
updatableTableColumns "termOfUse" = ["name", "description"]
updatableTableColumns "softwareAuthor" = ["Can't be updated. Press enter to exit"]
updatableTableColumns "statisticsOfUsage" = ["Can't be updated. Press enter to exit"]
updatableTableColumns x = []

checkUpdatableColumns :: String -> String -> Bool
checkUpdatableColumns tableName columnName = columnName `elem` updatableTableColumns tableName

getTableName :: String -> TableName
getTableName "software"                 = Software
getTableName "softwareType"             = Type
getTableName "author"                   = Author
getTableName "user"                     = User
getTableName "termOfUse"                = TermOfUse
getTableName "softwareAuthor"           = SoftwareAuthor
getTableName "statisticsOfUsage"        = StatisticsOfUsage
