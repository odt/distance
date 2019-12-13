{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE KindSignatures  #-}
{-# LANGUAGE RecordWildCards #-}
module Distance (degreePoint, toRadianPoint, distance) where

data Unit = Degree | Radian

data Point (a :: Unit) = Point { latitude :: Double, longitude :: Double }

degreePoint :: Double -> Double -> Point 'Degree
degreePoint latitude longitude = Point {..}

toRadianPoint :: Point 'Degree -> Point 'Radian
toRadianPoint Point {..} = Point { latitude = toRadian latitude, longitude = toRadian longitude }

-- | Distance in meters
--
-- >>> :seti -XDataKinds
-- >>> let p国土地理院 = degreePoint 36.10377477777778 140.08785502777778
-- >>> let p日本経緯度原点 = degreePoint 35.65502847222223 139.74475044444443
-- >>> abs (distance (toRadianPoint p国土地理院) (toRadianPoint p日本経緯度原点) - 58643.804) < 10
-- True
distance :: Point 'Radian -> Point 'Radian -> Double
distance source target =
  let
    averageLatitude = (latitude source + latitude target) / 2
    dLatitude       = latitude target - latitude source
    dLongitude      = longitude target - longitude source

    sqrtW = sqrt $ 1 - 0.006674 * sin averageLatitude ^ (2 :: Int)

    -- 子午線曲率半径
    m = 6334834 / sqrtW ^ (3 :: Int)

    -- 卯酉線曲率半径
    n = 6377397 / sqrtW
  in
    diagonal (m * dLatitude) (n * cos averageLatitude * dLongitude)

toRadian :: Double -> Double
toRadian x = x * pi / 180

diagonal :: Double -> Double -> Double
diagonal x y = sqrt $ x ^ (2 :: Int) + y ^ (2 :: Int)
