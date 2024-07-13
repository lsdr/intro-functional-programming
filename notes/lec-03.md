# LEC-03

In this lecture we will introduce a range of mechanisms for defining _functions_ in Haskell:

* Conditional expressions
* Guarded equations
* Pattern matching
* Lambda expressions
* Sections

## Conditional Expressions

Haskell _has no statements_

### Expressions

```haskell
abs :: Int -> Int
abs n = if n >= 0 then n else -n
```
Conditional Expressions can be nested:

```haskell
signum :: Int -> Int
signun n = if n < 0 then -1 else
              if n == 0 then 0 else 1
```

## Guarded Expressions

```haskell
abs n | n >= 0    = 0
      | otherwise = -n
```

_Haskell people_ prefer this way, to the conditional expression. _Guarded Equations_ are very idiomatic in Haskell.

It is possible to use guarded expressions on multiple conditions, just like nested expressions:

```haskell
signum n | n < 0     = -1
         | n == 0    = 0
         | otherwise = 1
```

`otherwise` is defined as `True` and it's a _catch all guard condition_ to the definition (works like a `if True; then` statement).

## Pattern Matching

```haskell
not      :: Bool -> Bool
not False = True
not True  = False
```

This is not _mapping_ values, but matching the function call argument to a part of the function definition-- thus _pattern matching_.

A ***Truth Table*** can be written like this:

```haskell
(&&)          :: Bool -> Bool -> Bool  
True  && True  = True
True  && False = False
False && True  = False
False && False = False
```

This is a functional implementation of _logical AND_.

But since there's only one situation where it can output `True`, which is when _both_ arguments are `True`, otherwise any pairing of arguments leads to `False`, we can rewrite the function definition as:

```haskell
True && True = True
_    && _    = False
```

The _underscore_ `_` is the traditional variable "I don't care about" placeholder -- fairly common on _pattern matching_.

But even the simplified definition can be simplified. ;-)

The problem with `True && True` as an argument is that it requires _both_ arguments to be eval'ed. It is preferable to rewrite this into something that can already lead to a correct answer without evaluating _both_ args.

So, a more _efficient_ and _idiomatic_ approach would be this:

```haskell
True  && b = b
False && _ = False
```

This avoids evaluating the second argument if the first is `False`, and returns the correct _truth table_ correctly.

### Things to consider:

1. In Haskell, patterns are matched _in order_. This would return `False` always:

  ```haskell
  _    && _    = False
  True && True = True
  ```
  Because it would match the _wildcard var_ in the first expression everytime, without checking the second pattern.

1. Patterns _may not_ repeat variables. This would throw an error:

  ```haskell
  b && b = b
  _ && _ = False
  ```

### List Patterns

Internally, every _non-empty_ list is constructed by repeated use of an operator (:) called ***"cons"*** that adds an element to the start of a list:

```
[1]          ==> 1:[]
[1, 2]       ==> 1:(2:[])
[1, 2, 3]    ==> 1:(2:(3:[]))
[1, 2, 3, 4] ==> 1:(2:(3:(4:[])))
```

This is _big_ on languages like LISP.

But _mostly important_, this is why a _pattern_ like `x:xs` works. `head`/`tail` functions could be implemented like this:

```haskell
head      :: [a] -> a
head (x:_) = x

tail       :: [a] -> [a]
tail (_:xs) = xs
```

It matches the _cons_ on `:` and appropriately split the `List`.

#### Caveats

* `x:xs` only matches on _non-empty_ lists. If the list is empty, Haskell will error.
* `x:xs` must be _parenthesised_, because the application has priority over `(:)` (application binds strongest). Something like `head x:_ = x` would error.

## Lambda Expression

Why Lambda expressions? Lambda expressions can be used to give a formal meaning to functions defined using _currying_.

```haskell
add x y = x+y
```
As a _lambda expression_:

```haskell
\x -> (\y -> x+y)
```

Also useful (and idiomatic) when defining functions that return _functions as results_.

```haskell
const    :: a -> b -> a
const x _ = x
```
As a _lambda expression_:

```haskell
const  :: a -> (b -> a)
const x = \_ -> x
```

It's weird `\_` but means a lambda that receives _whatever_ and return `x`.

And, of course, lambda expression is useful to avoid naming functions.

```haskell
odds n = map f [0..n-1]
         where
            f x = x * 2 + 1
```

As a _lambda expression_:

```haskell
odds n = map (\x -> x * 2 + 1) [0..n-1]
```

## Section

An operator written between its to args can be converted into a curried function written _before_ the args and parenthezised:

```haskell
Main> 1 + 2
3
Main> (+) 1 2
3
Main> (1+) 2
3
Main> (+2) 1
3
Main> map (*2) [0..10]
[0,2,4,6,8,10,12,14,16,18,20]
```