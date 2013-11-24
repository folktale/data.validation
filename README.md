monads.validation
=================

[![Build Status](https://secure.travis-ci.org/folktale/monads.validation.png?branch=master)](https://travis-ci.org/folktale/monads.validation)
[![NPM version](https://badge.fury.io/js/monads.validation.png)](http://badge.fury.io/js/monads.validation)
[![Dependencies Status](https://david-dm.org/folktale/monads.validation.png)](https://david-dm.org/folktale/monads.validation)
[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)


A disjunction (Either monad) that's more appropriate for validating inputs with better vocabulary & straight-forward failure aggregation.


## Example

```js
( ... )
```


## Installing

The easiest way is to grab it from NPM. If you're running in a Browser
environment, you can use [Browserify][]

    $ npm install monads.validation


### Using with CommonJS

If you're not using NPM, [Download the latest release][release], and require
the `monads.validation.umd.js` file:

```js
var Validation = require('monads.validation')
```


### Using with AMD

[Download the latest release][release], and require the `monads.validation.umd.js`
file:

```js
require(['monads.validation'], function(Validation) {
  ( ... )
})
```


### Using without modules

[Download the latest release][release], and load the `monads.validation.umd.js`
file. The properties are exposed in the global `Validation` object:

```html
<script src="/path/to/monads.validation.umd.js"></script>
```


### Compiling from source

If you want to compile this library from the source, you'll need [Git][],
[Make][], [Node.js][], and run the following commands:

    $ git clone git://github.com/folktale/monads.validation.git
    $ cd monads.validation
    $ npm install
    $ make bundle
    
This will generate the `dist/monads.validation.umd.js` file, which you can load in
any JavaScript environment.

    
## Documentation

You can [read the documentation online][docs] or build it yourself:

    $ git clone git://github.com/folktale/monads.maybe.git
    $ cd monads.maybe
    $ npm install
    $ make documentation

Then open the file `docs/literate/index.html` in your browser.


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :)


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/folktale/monads.validation/blob/master/LICENCE).

<!-- links -->
[Fantasy Land]: https://github.com/fantasyland/fantasy-land
[Browserify]: http://browserify.org/
[release]: https://github.com/folktale/monads.validation/releases/download/v0.0.0/monads.validation-0.0.0.tar.gz
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/
[es5-shim]: https://github.com/kriskowal/es5-shim
[docs]: http://folktale.github.io/monads.validation
