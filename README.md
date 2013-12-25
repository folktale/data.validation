The Validation Applicative
==========================

[![Build Status](https://secure.travis-ci.org/folktale/data.validation.png?branch=master)](https://travis-ci.org/folktale/data.validation)
[![NPM version](https://badge.fury.io/js/data.validation.png)](http://badge.fury.io/js/data.validation)
[![Dependencies Status](https://david-dm.org/folktale/data.validation.png)](https://david-dm.org/folktale/data.validation)
[![stable](http://hughsk.github.io/stability-badges/dist/stable.svg)](http://github.com/hughsk/stability-badges)

The `Validation(a, b)` is a disjunction that's more appropriate for validating
inputs, or any use case where you want to aggregate failures. Not only the
`Validation` provides a better terminology for working with such cases
(`Failure` and `Success` versus `Left` and `Right`), it also allows one to
easily aggregate failures and successes as an Applicative Functor.


## Example

```js
var Validation = require('data.validation')
var Success = Validation.Success
var Failure = Validation.Failure

function isPasswordLongEnough(a) {
  return a.length > 6?    Success(a)
  :      /* otherwise */  Failure("Password must have more than 6 characters")
}

function isPasswordStrongEnough(a) {
  return /[\W]/.test(a)?  Success(a)
  :      /* otherwise */  Failure("Password must contain special characters")
}

function isPasswordValid(a) {
  return [isPasswordLongEnough(a), isPasswordStrongEnough(a)]
           .map(function(x){ return x.bimap(liftNel, k) })
           .reduce(function(a, b) { return a.ap(b) })
}

function liftNel(a) {
  return [a]
}

function k(a) { return function(b) {
  return a
}}

isPasswordValid("foo")
// => Validation.Failure([
//      "Password must have more than 6 characters.",
//      "Password must contain special characters."
//    ])

isPasswordValid("rosesarered")
// => Validation.Failure([
//      "Password must contain special characters."
//    ])

isPasswordValid("rosesarered$andstuff")
// => Validation.Success("rosesarered$andstuff")
```


## Installing

The easiest way is to grab it from NPM. If you're running in a Browser
environment, you can use [Browserify][]

    $ npm install data.validation


### Using with CommonJS

If you're not using NPM, [Download the latest release][release], and require
the `data.validation.umd.js` file:

```js
var Validation = require('data.validation')
```


### Using with AMD

[Download the latest release][release], and require the `data.validation.umd.js`
file:

```js
require(['data.validation'], function(Validation) {
  ( ... )
})
```


### Using without modules

[Download the latest release][release], and load the `data.validation.umd.js`
file. The properties are exposed in the global `folktale.data.validation` object:

```html
<script src="/path/to/data.validation.umd.js"></script>
```


### Compiling from source

If you want to compile this library from the source, you'll need [Git][],
[Make][], [Node.js][], and run the following commands:

    $ git clone git://github.com/folktale/data.validation.git
    $ cd data.validation
    $ npm install
    $ make bundle
    
This will generate the `dist/data.validation.umd.js` file, which you can load in
any JavaScript environment.

    
## Documentation

You can [read the documentation online][docs] or build it yourself:

    $ git clone git://github.com/folktale/data.validation.git
    $ cd data.validation
    $ npm install
    $ make documentation

Then open the file `docs/literate/index.html` in your browser.


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :)


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/folktale/data.validation/blob/master/LICENCE).

<!-- links -->
[Fantasy Land]: https://github.com/fantasyland/fantasy-land
[Browserify]: http://browserify.org/
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/
[es5-shim]: https://github.com/kriskowal/es5-shim
[docs]: http://folktale.github.io/data.validation
<!-- [release: https://github.com/folktale/data.validation/releases/download/v$VERSION/data.validation-$VERSION.tar.gz] -->
[release]: https://github.com/folktale/data.validation/releases/download/v1.0.0/data.validation-1.0.0.tar.gz
<!-- [/release] -->

