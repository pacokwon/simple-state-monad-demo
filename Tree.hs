module Tree where

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

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Show

label :: Tree a -> Int -> (Tree Int, Int)
label (Leaf v) n = (Leaf n, n + 1)
label (Node l r) n = (Node l' r', n'')
    where
        (l', n') = label l n
        (r', n'') = label r n'

mlabel :: Tree a -> StateT Int (Tree Int)
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
    let labeled = fst $ runStateT (mlabel testTree) 0
    print labeled
