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

dist/data.validation.umd.js: compile dist
	$(browserify) lib/index.js --standalone folktale.data.validation > $@

dist/data.validation.umd.min.js: dist/data.validation.umd.js
	$(uglify) --mangle - < $^ > $@

# ----------------------------------------------------------------------
bundle: dist/data.validation.umd.js

minify: dist/data.validation.umd.min.js

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
	mkdir -p dist/data.validation-$(VERSION)
	cp -r docs/literate dist/data.validation-$(VERSION)/docs
	cp -r lib dist/data.validation-$(VERSION)
	cp dist/*.js dist/data.validation-$(VERSION)
	cp package.json dist/data.validation-$(VERSION)
	cp README.md dist/data.validation-$(VERSION)
	cp LICENCE dist/data.validation-$(VERSION)
	cd dist && tar -czf data.validation-$(VERSION).tar.gz data.validation-$(VERSION)

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
