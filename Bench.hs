import Criterion (Benchmark, bench, bgroup, env, nf)
import Criterion.Main (defaultMain)
import Tardis
import Test.QuickCheck (arbitrary, generate, vectorOf)

data TestType = Naive | TardisManual | Tardis
  deriving (Show)

mkList :: Int -> IO [Int]
mkList n = generate (vectorOf n arbitrary)

mkBench :: Int -> TestType -> Benchmark
mkBench n ty = env (mkList n) $ \ ~xs -> bgroup (show ty) [bench (show n) $ nf f xs]
  where
    f = case ty of
      Naive -> removeModeNaive
      TardisManual -> removeModeTardisManual
      Tardis -> removeModeTardis

main :: IO ()
main = defaultMain
  [ mkBench 100 Naive
  , mkBench 1000 Naive
  , mkBench 10000 Naive
  , mkBench 100 TardisManual
  , mkBench 1000 TardisManual
  , mkBench 10000 TardisManual
  , mkBench 100 Tardis
  , mkBench 1000 Tardis
  , mkBench 10000 Tardis
  ]
