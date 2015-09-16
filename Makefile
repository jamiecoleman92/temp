.PHONY: all test clean

test:
	websphere-liberty/test/buildAndVerify.sh websphere-liberty websphere-liberty/beta/
