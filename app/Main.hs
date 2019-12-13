module Main (main) where

import           Csv      (fromCSVLine, toCSVLine)
import           Distance (degreePoint, distance, toRadianPoint)

main :: IO ()
main =
  interact $ unlines . map (toCSVLine . f . fromCSVLine) . lines
  where
    f input@[la, ln, la', ln'] = input ++ [distance (toRadianPoint (degreePoint la ln)) (toRadianPoint (degreePoint la' ln'))]
    f _ = error "Expect 4 columns"
