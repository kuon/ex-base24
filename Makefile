MDCAT:=$(firstword $(shell which mdcat cat 2>/dev/null))

.PHONY: help
help:
	$(MDCAT) MAKE.md

.PHONY: readme
readme:
	$(MDCAT) README.md

.PHONY: build
build:
	mix compile

.PHONY: test
test:
	mix test

.PHONY: clean
clean:
	rm -fr _build deps

.PHONY: publish
publish:
	mix hex.publish

