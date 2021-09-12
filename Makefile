CC = ghc

%: %.hs
	$(CC) -main-is $* $*.hs
