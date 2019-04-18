import Tardis
import Test.QuickCheck (Gen, arbitrary)
import Test.Tasty
import Test.Tasty.QuickCheck

testRemoveMode :: ([Int] -> [Int]) -> Gen Property
testRemoveMode f = do
  Positive n <- arbitrary
  let src = [1..n]

  theMode <- elements src
  theModeCount <- arbitrary

  let genDups x = do
        count <- if x == theMode
          then return theModeCount
          else choose (0, theModeCount - 1)
        return $ replicate count x

  xs <- shuffle . concat =<< mapM genDups src
  let result = filter (/= theMode) xs

  return $ f xs === result

main :: IO ()
main = defaultMain $ testGroup "Tests"
  [ testProperty "naive" $ testRemoveMode removeModeNaive
  , testProperty "tardis-manual" $ testRemoveMode removeModeTardisManual
  , testProperty "tardis" $ testRemoveMode removeModeTardis
  ]
