TESTS = test/*.coffee
export NODE_PATH=.

test: 
	@NODE_ENV=test ./node_modules/.bin/mocha $(TESTS)

.PHONY: test 
