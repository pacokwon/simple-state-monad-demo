# Simple `State` Monad Demo

This repository contains sample files for demonstrating the workings of the `State` monad. Codes here were written for [my personal blog post](https://pacokwon.github.io/posts/20210911-simple-state-monad).


## Directory Structure
```
 .
├──  Plain.hs      -- first naive attempt
├──  Bind.hs       -- intermediate refactor with bind function
├──  Main.hs       -- final version with monad instance
├──  Tree.hs       -- code for tree example
├──  Lib.hs
├──  Makefile
└──  README.md
```

## Getting Started
Each file (`Plain.hs`, `Bind.hs`, `Main.hs`, `Tree.hs`) contains a main function. To run each file, compile with `make` and run the executable. For example:
```bash
$ make Plain && ./Plain
```
