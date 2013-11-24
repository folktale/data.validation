# # monads.validation
#
# The `Validation(a, b)` is a disjunction that's more appropriate for
# validating inputs, or any use case where you want to aggregate
# failures. Not only the `Validation` monad provides a better
# terminology for working with such cases (`Failure` and `Success`
# versus `Left` and `Right`), it also allows one to easily aggregate
# failures and successes as an Applicative Functor.

/** ^
 * Copyright (c) 2013 Quildreen Motta
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation files
 * (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

# ## Class: Validation(a, b)
#
# The `Validation(a, b)` monad.
#
# + type: Validation(a, b) <: Applicative, Functor, Chain, Show, Eq
class Validation
  ->

  # ### Section: Constructors ##########################################

  # #### Function: Failure
  #
  # Constructs a new `Validation(a, b)` monad holding a `Failure` value.
  #  
  # + type: a -> Validation(a, b)
  Failure: (a) -> new Failure(a)

  # #### Function: Success
  #
  # Constructs a new `Validation(a, b)` monad holding a `Success` value.
  #  
  # + type: b -> Validation(a, b)
  Success: (b) -> new Success(b)

  # #### Function: from-nullable
  #
  # Constructs a new `Validation(a, b)` from a nullable type. Takes the
  # `Failure` case if the value is `null` or `undefined`. Takes the
  # `Success` case otherwise.
  #
  # + type: a -> Validation(a, a)
  from-nullable: (a) ->
    | a? => new Success(a)
    | _  => new Failure(a)


  # ### Section: Predicates ############################################

  # #### Field: is-failure
  #
  # True if the `Validation(a, b)` contains a `Failure` value.
  #
  # + type: Boolean
  is-failure: false

  # #### Field: is-success
  #
  # True if the `Validation(a, b)` contains a `Success` value.
  #
  # + type: Boolean
  is-success: false


  # ### Section: Applicative ###########################################

  # #### Function: of
  #
  # Creates a new `Validation(a, b)` instance holding the `Success`
  # value `b`.
  #  
  # `b` can be any value, including `null`, `undefined` or another
  # `Validation(a, b)` monad.
  #  
  # + type: b -> Validation(a, b)
  of: (b) -> new Success(b)

  # #### Function: ap
  #
  # If both applicatives represent a `Success` value, maps the value in
  # the given validation with the function in this validation. Otherwise
  # aggregates the errors with a semigroup — both Failures must hold a
  # semigroup.
  #  
  # + type: (@Validation(a, b -> c)) => Validation(a, b) -> Validation(a, c)
  ap: (_) -> ...


  # ### Section: Functor ###############################################

  # #### Function: map
  #
  # Transforms the `Success` value of the `Validation(a, b)` monad using
  # a regular unary function.
  #  
  # + type: (@Validation(a, b)) => (b -> c) -> Validation(a, c)
  map: (_) -> ...


  # ### Section: Chain #################################################

  # #### Function: chain
  #
  # Transforms the `Success` value of the `Validation(a, b)` monad using
  # an unary function to a monad of the same type.
  #  
  # + type: (@Validation(a, b)) => (b -> Validation(a, c)) -> Validation(a, c)
  chain: (_) -> ...


  # ### Section: Show ##################################################

  # #### Function: to-string
  #
  # Returns a textual representation of the `Validation(a, c)` monad.
  #  
  # + type: (@Validation(a, b)) => Unit -> String
  to-string: -> ...


  # ### Section: Eq ####################################################

  # #### Function: is-equal
  #
  # Tests if an `Validation(a, b)` monad is equal to another
  # `Validation(a, b)` monad.
  #
  # + type: (@Validation(a, b)) => Validation(a, b) -> Boolean
  is-equal: (_) -> ...


  # ### Section: Extracting and Recovering #############################

  # #### Function: get
  #
  # Extracts the `Success` value out of the `Validation(a, b)` monad, if
  # it exists. Otherwise throws a `TypeError`.
  #  
  # + see: get-or-else — A getter that can handle failures.
  # + see: merge — Returns the convergence of both values.
  # + type: (@Validation(a, b), *throws) => Unit -> b
  # + throws: TypeError — if the monad doesn't have a `Success` value.
  get: -> ...

  # #### Function: get-or-else
  #
  # Extracts the `Success` value out of the `Validation(a, b)` monad. If
  # the monad doesn't have a `Success` value, returns the given default.
  #
  # + type: (@Validation(a, b)) => b -> b
  get-or-else: (_) -> ...

  # #### Function: or-else
  #
  # Transforms a `Failure` value into a new `Validation(a, b)`
  # monad. Does nothing if the monad contains a `Success` value.
  #
  # + type: (@Validation(a, b)) => (a -> Validation(c, b)) -> Validation(c, b)
  or-else: (_) -> ...

  # #### Function: merge
  #
  # Returns the value of whichever side of the disjunction that is
  # present.
  #
  # + type: (@Validation(a, a)) => Unit -> a
  merge: -> @value


  # ### Section: Folds and Extended Transformations ####################

  # #### Function: fold
  #
  # Catamorphism. Takes two functions, applies the leftmost one to the
  # `Failure` value and the rightmost one to the `Success` value,
  # depending on which one is present.
  #
  # + type: (@Validation(a, b)) => (a -> c) -> (b -> c) -> c
  fold: (f, g) --> ...

  # #### Function: swap
  #
  # Swaps the disjunction values.
  #  
  # + type: (@Validation(a, b)) => Unit -> Validation(b, a)
  swap: -> ...

  # #### Function: bimap
  #
  # Maps both sides of the disjunction.
  #
  # + type: (@Validation(a, b)) => (a -> c) -> (b -> d) -> Validation(c, d)
  bimap: (f, g) --> ...
  
  # #### Function: left-map
  #
  # Maps the left side of the disjunction.
  #  
  # + type: (@Validation(a, b)) => (a -> c) -> Validation(c, b)
  left-map: (f) -> ...


# ## Class: Success(a)
#
# Represents the `Success` side of the disjunction.
class Success extends Validation
  (@value) ->
  is-success: true
  ap: (b) ->
    | b.is-failure => b
    | otherwise    => new Success(@value b.value)
  map: (f) -> @of (f @value)
  chain: (f) -> f @value
  to-string: -> "Validation.Success(#{@value})"
  is-equal: (a) -> a.is-success and (a.value is @value)
  get: -> @value
  get-or-else: (_) -> @value
  or-else: (_) -> this
  fold: (_, g) -> g @value
  swap: -> new Failure(@value)
  bimap: (_, g) -> new Success(g @value)
  left-map: (_) -> this
  

# ## Class: Failure(a)
#
# Represents the `Failure` side of the disjunction.
class Failure extends Validation
  (@value) ->
  is-failure: true
  ap: (b) ->
    | b.is-failure => new Failure(@value ++ b.value)
    | otherwise    => this
  map: (_) -> this
  chain: (_) -> this
  to-string: -> "Validation.Failure(#{@value})"
  is-equal: (a) -> a.is-failure and (a.value is @value)
  get: -> throw new TypeError("Can't extract the value of a Failure(a)")
  get-or-else: (a) -> a
  or-else: (f) -> f @value
  fold: (f, _) -> f @value
  swap: -> new Success(@value)
  bimap: (f, _) -> new Failure(f @value)
  left-map: (f) -> new Failure(f @value)


# ## Exports
module.exports = new Validation
  
