# LEC-06

_Higher-order Functions_ are the ultimate solution to DRY.

In this lecture we introduce a number of standard higher-order functions over lists, functions for creating and manipulating other functions.

## Introduction

A function is called _higher-order_ if it takes a function as an argument or returns a function as a result:

```haskell
twice    :: (a -> a) -> a -> a
twice f x = f (f x)
```

## Why HOF Useful?

* Commom programming idioms-- can be encoded as functions within the language itself
* Domain-specific languages-- can be defined as collections of higher-order functions
* Algebraic properties of higher-order functions can be used to reason about the program

## The `map` Function

```haskell
map :: (a -> b) -> [a] -> [b]
```
Example:

```haskell
Main> map (+1) [1, 3, 5]
[2, 4, 6]
```

The `map` function can be defined in a particularly simple manner using a list comprehension:

```haskell
map f xs = [f x | x <- xs]
```
Or, alternatively:

```haskell
map f []     = []
map f (x:xs) = f x : map f xs
```

## The `filter` Function

As a list comprehension:

```haskell
filter p xs = [x | x <- xs, p x]
```
Or as a recursive function:

```haskell
filter p []    = []
filter p (x:xs)
   | p x       = x : filter p xs
   | otherwise = filter p xs
```

Looking at the commonality between `map` and `filter`, it hints that we should be able to extract something out of their recursive implementations.


##The `foldr` function