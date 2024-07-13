# LEC-02

In this lecture we introduce types and type classes, two of the most fundamental concepts in Haskell.

We start by informally explaining what types are and how they are used in Haskell, then present a number of basic types and ways to build compound types by composing smaller types, discuss function types in more detail, and conclude with the concept of parametric polymorphism (generics) and type classes.

## What is a type?

A _Type_ is a name for a collection of related values.

`Bool` type has two _logical_ values: `True` and `False`

### Types in Haskell

```haskell
e :: t
```

If evaluating an expression `e` would produce a value of type `t`, then `e` _has type_ `t`.

Haskell has _type inference_ and can calculate types at runtime.

### Type Error

```haskell
Main> 1 + False
Error
```

The function `+` requires two _numbers_, but `False` is `Bool`. This kind of type mismatch is called _Type Error_.

All type errors are found at compile time. There's no _type checks_ at runtime.

### Basic Types

* `Bool`
* `Char`
* `String` (a `List` of `Char`, actually)
* `Int` (fixed-precision)
* `Integer` (arbitrary-precision, takes more time but does not overflow)
* `Float`

#### List Types

`List` is a polymorphic Type, but all the elements must have the same type:

```haskell
[False, True] :: [Bool]
['a', 'b', 'c'] :: [Char]
```

A type of a list _doesn't say nothing_ about list size.

#### Tuple Types

`Tuple` is a sequence of values can be diferrent.

```haskell
(False, 'a', True) :: (Bool, Char, Bool)
(True, ['a', 'b']) :: (Bool, [Char])
```

The size of a Tuple "encodes" it's size.

## Function Types

A function is a mapping from values of one type to values of another type:

```haskell
not     :: Bool -> Bool
isDigit :: Char -> Bool
```

In `isDigit`, `Char` is sometimes called the _domain of the function_ and `Bool` the _range of the function_.

```haskell
add		   :: (Int, Int) -> Int
add (x,y) = x + y
```

### Curried Functions

```haskell
add'    :: Int -> (Int -> Int)
add' x y = x + y
```

The function `add'` takes an integer `x` and returns a function `add' x`. In turn, this function takes an integer `y` and returns as `x+y`.

_Every function with two or more arguments can be turned into a function that gets is params one-by-one_.

#### Why is Currying useful?

Simplified and _light weight_ and Haskell is optimized for currying work.

#### Idioms

Avoid excess parentheses:

```haskell
Int -> (Int, Int, Int)
Int -> Int, Int, Int
```

---
```haskell
mult x y z
```

Means _logically_:

```haskell
((mult x) y) z
```

## Polymorphic Functions and Type Classes

***polymorphic*** - "of many forms"

Function is polymorphic if its type contains one or more variables, not concrete types.

```haskell
length :: [a] -> Int
```

To calculate the _length_ of a `List`, it doesn't matter at all the _type_ of the elements of that list.

* `Int` is a concrete type (the uppercase I give it away)
* `a` is a ***type variable***-- for any type of `a`, _length_ takes a list of values and returns an integer

```haskell
Main> length [False, True]
2
Main> length [0..10]
11
```

The _idiom_ is: must begin with lowercase letters, usually named `a`, then `b`, `c`...

### Examples

```haskell
fst  :: (a, b) -> a
head :: [a] -> a
take :: Int -> [a] -> [a]
zip  :: [a] -> [b] -> [(a,b)]
id   :: a -> a
```

`take` takes an `Int` and returns a function, that takes a `List` and returns a `List` (`take :: Int -> ([a] -> [a])`, _parens_ optional)

Reference Read: [Theorems for Free](http://ttic.uchicago.edu/~dreyer/course/papers/wadler.pdf), by Philip  Wadler

### Overloaded Functions

A polymorphic function is called _overloaded_ if its type contains one (or more) class _contraints_.

```haskell
sum :: Num a => [a] -> a
```

This _restricts_ the Types that the `sum` function can take.

```haskell
Main> sum ['a', 'b']
ERROR - Cannot infer instance
*** Instance   : Num Char
*** Expression : sum ['a','b']
```

