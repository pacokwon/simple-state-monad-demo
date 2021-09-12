module Main where

import Control.Applicative
import Lib

instance Functor (StateT a) where
  -- fmap :: (a -> b) -> StateT s a -> StateT s b
  fmap f (S transform) = S (\s -> let (r, s') = transform s in (f r, s'))

instance Applicative (StateT a) where
  -- pure :: a -> StateT s a
  pure x = S $ \s -> (x, s)

  -- (<*>) :: StateT s (a->b) -> StateT s a -> StateT s b
  sf <*> sa = S $ \s ->
    let (f', s') = runStateT sf s
     in runStateT (f' `fmap` sa) s'

instance Monad (StateT a) where
  -- (>>=) :: StateT s a -> (a -> StateT s b) -> StateT s b
  (S f) >>= t = S $ \s ->
    let (a, s') = f s in runStateT (t a) s'

nextThree :: StateT Int (Int, Int, Int)
nextThree = do
  id <- next
  id' <- next
  id'' <- next
  return (id, id', id'')

getThreeIds :: Int -> (Int, Int, Int)
getThreeIds start = fst $ runStateT nextThree start

main :: IO ()
main = do
  let (id, id', id'') = getThreeIds 0
  print id
  print id'
  print id''
