module Tree where

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

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

label :: Tree a -> Int -> (Tree Int, Int)
label (Leaf v) n = (Leaf n, n + 1)
label (Node l r) n = (Node l' r', n'')
    where
        (l', n') = label l n
        (r', n'') = label r n'

mlabel :: Tree a -> State Int (Tree Int)
mlabel (Leaf v) = do
    n <- next
    return (Leaf n)

mlabel (Node l r) = do
    l' <- mlabel l
    r' <- mlabel r
    return (Node l' r')

testTree :: Tree String
testTree = Node (Leaf "foo") (Node (Leaf "bar") (Leaf "baz"))

main :: IO ()
main = do
    -- naïve version
    let labeled = fst $ label testTree 0
    print labeled
    -- monad version version
    let labeled = fst $ runState (mlabel testTree) 0
    print labeled
