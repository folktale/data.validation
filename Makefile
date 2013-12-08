bin        = $(shell npm bin)
lsc        = $(bin)/lsc
browserify = $(bin)/browserify
groc       = $(bin)/groc
uglify     = $(bin)/uglifyjs
VERSION    = $(shell node -e 'console.log(require("./package.json").version)')


lib: src/*.ls
	$(lsc) -o lib -c src/*.ls

dist:
	mkdir -p dist

dist/monads.validation.umd.js: compile dist
	$(browserify) lib/index.js --standalone folktale.monads.Validation > $@

dist/monads.validation.umd.min.js: dist/monads.validation.umd.js
	$(uglify) --mangle - < $^ > $@

# ----------------------------------------------------------------------
bundle: dist/monads.validation.umd.js

minify: dist/monads.validation.umd.min.js

compile: lib

documentation:
	$(groc) --index "README.md"                                              \
	        --out "docs/literate"                                            \
	        src/*.ls test/*.ls test/specs/**.ls README.md

clean:
	rm -rf dist build lib

test:
	$(lsc) test/tap.ls

package: compile documentation bundle minify
	mkdir -p dist/monads.validation-$(VERSION)
	cp -r docs/literate dist/monads.validation-$(VERSION)/docs
	cp -r lib dist/monads.validation-$(VERSION)
	cp dist/*.js dist/monads.validation-$(VERSION)
	cp package.json dist/monads.validation-$(VERSION)
	cp README.md dist/monads.validation-$(VERSION)
	cp LICENCE dist/monads.validation-$(VERSION)
	cd dist && tar -czf monads.validation-$(VERSION).tar.gz monads.validation-$(VERSION)

publish: clean
	npm install
	npm publish

bump:
	node tools/bump-version.js $$VERSION_BUMP

bump-feature:
	VERSION_BUMP=FEATURE $(MAKE) bump

bump-major:
	VERSION_BUMP=MAJOR $(MAKE) bump


.PHONY: test
