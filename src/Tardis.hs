{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Tardis where

import Control.Monad.Tardis (MonadTardis(..), Tardis, evalTardis)
import Data.Function (on)
import Data.Hashable (Hashable)
import qualified Data.HashMap.Strict as HM
import Data.List (maximumBy)

-- | Removes the most common element in the list.
removeModeNaive :: (Eq a, Hashable a) => [a] -> [a]
removeModeNaive l = filter (/= maxKey) l
  where
    countMap = HM.fromListWith (+) $ zip l (repeat 1)
    maxKey = getMaxKey countMap

-- | removeModeNaive, but using the same operations as the Tardis monad.
removeModeTardisManual :: (Eq a, Hashable a) => [a] -> [a]
removeModeTardisManual l = let (l', maxKey) = helper l HM.empty maxKey in l'
  where
    helper [] countMap _ = ([], getMaxKey countMap)
    helper (x:xs) countMap maxKey =
      let countMap' = HM.insertWith (+) x 1 countMap
          (xs', maxKey') = helper xs countMap' maxKey
      in (if x == maxKey then xs' else x:xs', maxKey')

-- | removeModeNaive, but using the actual Tardis monad.
removeModeTardis :: (Eq a, Hashable a) => [a] -> [a]
removeModeTardis l = evalTardis (helper l) (undefined, HM.empty)
  where
    helper :: (Eq a, Hashable a) => [a] -> Tardis a (HM.HashMap a Int) [a]
    helper [] = do
      countMap <- getPast
      sendPast $ getMaxKey countMap
      return []
    helper (x:xs) = do
      countMap <- getPast
      let countMap' = HM.insertWith (+) x 1 countMap
      sendFuture countMap'
      maxKey <- getFuture
      xs' <- helper xs
      return $ if x == maxKey then xs' else x:xs'

{- Helpers -}

getMaxKey :: HM.HashMap a Int -> a
getMaxKey = fst . maximumBy (compare `on` snd) . HM.toList
