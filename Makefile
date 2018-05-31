test:
	nix-shell --run 'cabal configure; cabal build; dist/build/warp-close-test/warp-close-test & PID=$$!; sleep 1; echo "Sending SIGTERM..."; kill -s SIGTERM $$PID; sleep 5; echo "Sending SIGKILL"; kill -9 $$PID;'
