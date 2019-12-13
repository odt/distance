module Csv (fromCSVLine, toCSVLine) where

import           Data.List       (intercalate)
import           Data.List.Split (splitOn)

fromCSVLine :: Read a => String -> [a]
fromCSVLine = map read . splitOn [',']

toCSVLine :: Show a => [a] -> String
toCSVLine = intercalate "," . map show
