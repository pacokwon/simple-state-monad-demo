module Plain where

import Lib

main :: IO ()
main = do
    let n0 = 0
    let (id, n)     = runStateT next n0
    let (id', n')   = runStateT next n
    let (id'', n'') = runStateT next n'
    print id    -- 0
    print id'   -- 1
    print id''  -- 2
    print n''   -- 3
