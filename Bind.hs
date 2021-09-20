module Bind where

import Lib

bind :: State s a -> (a -> State s b) -> State s b
bind sa f = S $ \s ->
  let (a, s') = runState sa s in runState (f a) s'

main :: IO ()
main = fst $ runState (
    next `bind` \id ->
    next `bind` \id' ->
    next `bind` \id'' ->
    S $ \s -> (
      do
        print id
        print id'
        print id'',
      s
    ))
  0
