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

dist/applicatives.validation.umd.js: compile dist
	$(browserify) lib/index.js --standalone folktale.applicatives.Validation > $@

dist/applicatives.validation.umd.min.js: dist/applicatives.validation.umd.js
	$(uglify) --mangle - < $^ > $@

# ----------------------------------------------------------------------
bundle: dist/applicatives.validation.umd.js

minify: dist/applicatives.validation.umd.min.js

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
	mkdir -p dist/applicatives.validation-$(VERSION)
	cp -r docs/literate dist/applicatives.validation-$(VERSION)/docs
	cp -r lib dist/applicatives.validation-$(VERSION)
	cp dist/*.js dist/applicatives.validation-$(VERSION)
	cp package.json dist/applicatives.validation-$(VERSION)
	cp README.md dist/applicatives.validation-$(VERSION)
	cp LICENCE dist/applicatives.validation-$(VERSION)
	cd dist && tar -czf applicatives.validation-$(VERSION).tar.gz applicatives.validation-$(VERSION)

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
