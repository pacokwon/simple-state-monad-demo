module Lib where

-- a type that contains a state transformer
-- the state transformer accepts a state, and returns a state with some return value
newtype StateT a b = S {getStateT :: a -> (b, a)}

runStateT :: StateT a b -> a -> (b, a)
runStateT S {getStateT = f} = f

next :: StateT Int Int
next = S $ \n -> (n, n + 1)
