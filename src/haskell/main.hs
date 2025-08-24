import Data.Bits (xor)

collatzLenAndPeak :: Int -> (Int, Int)
collatzLenAndPeak x = go 0 x x
  where
    go steps peak n
      | n == 1 = (steps, peak)
      | even n = go (steps + 1) (max peak (n `div` 2)) (n `div` 2)
      | otherwise = let next = 3 * n + 1
                    in go (steps + 1) (max peak next) next

scanUpto :: Int -> (Int, Int, Int, Int)
scanUpto n = go 1 1 0 1 0
  where
    go i bestN bestSteps bestPeak xorSteps
      | i > n = (bestN, bestSteps, bestPeak, xorSteps)
      | otherwise =
          let (steps, peak) = collatzLenAndPeak i
              newXorSteps = xorSteps `xor` steps
              (newBestN, newBestSteps, newBestPeak) =
                if steps > bestSteps
                then (i, steps, peak)
                else (bestN, bestSteps, bestPeak)
          in go (i + 1) newBestN newBestSteps newBestPeak newXorSteps

main :: IO ()
main = do
  putStrLn "hello world!"
  let n = 1000000
      (bestN, bestSteps, bestPeak, xorSteps) = scanUpto n
  putStrLn $ "collatz_longest(1.." ++ show n ++ ")"
  putStrLn $ "n*=" ++ show bestN
  putStrLn $ "steps=" ++ show bestSteps
  putStrLn $ "peak=" ++ show bestPeak
  putStrLn $ "xor_steps=" ++ show xorSteps
