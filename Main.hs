module Main where

import Control.Applicative
import Lib

instance Functor (State a) where
  -- fmap :: (a -> b) -> State s a -> State s b
  fmap f (S transform) = S (\s -> let (r, s') = transform s in (f r, s'))

instance Applicative (State a) where
  -- pure :: a -> State s a
  pure x = S $ \s -> (x, s)

  -- (<*>) :: State s (a->b) -> State s a -> State s b
  sf <*> sa = S $ \s ->
    let (f', s') = runState sf s
     in runState (f' `fmap` sa) s'

instance Monad (State a) where
  -- (>>=) :: State s a -> (a -> State s b) -> State s b
  (S f) >>= t = S $ \s ->
    let (a, s') = f s in runState (t a) s'

nextThree :: State Int (Int, Int, Int)
nextThree = do
  id <- next
  id' <- next
  id'' <- next
  return (id, id', id'')

getThreeIds :: Int -> (Int, Int, Int)
getThreeIds start = fst $ runState nextThree start

main :: IO ()
main = do
  let (id, id', id'') = getThreeIds 0
  print id
  print id'
  print id''
