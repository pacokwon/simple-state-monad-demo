module Lib where

-- accept a state, and return a state with some return value
newtype State a b = S {getState :: a -> (b, a)}

runState :: State a b -> a -> (b, a)
runState S {getState = f} = f

next :: State Int Int
next = S $ \n -> (n, n + 1)
