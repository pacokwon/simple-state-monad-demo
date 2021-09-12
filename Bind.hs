module Bind where

import Lib

bind :: StateT s a -> (a -> StateT s b) -> StateT s b
bind sa f = S $ \s ->
  let (a, s') = runStateT sa s in runStateT (f a) s'

main :: IO ()
main = fst $ runStateT (
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
