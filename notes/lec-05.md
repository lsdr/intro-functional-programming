# LEC-05

In Haskell all repetition is expressed using _recursion_.

We start with recursion over integers, extend it to recursion over lists, mutual recursion, and conclude with some advice on whether to use explicit recursion or not.

---
### Tail-call elimination

* [TailCallOptimization](http://c2.com/cgi/wiki?TailCallOptimization) on c2wiki
* <https://en.wikipedia.org/wiki/Tail_call>

---

## Introduction

Functions can be defined in terms of other functions:

```haskell
factorial  :: Int -> Int
factorial n = product [1..n]
```

The evaluation would go like this:

1. `factorial 4`
2. `product [1..4]`
3. `product [1,2,3,4]`
4. `1 * 2 * 3 * 4`

## Recursive Functions

Functions can also be defined in terms of themselves. Such functions are called _recursive_:

```haskell
factorial 0 = 1
factorial n = n * factorial (n-1)
```

The evaluation would go like this:

1. `factorial 3`
2. `3 * factorial 2`
3. `3 * (2 * factorial 1)`
4. `3 * (2 * (1 * factorial 0))`
5. `3 * (2 * (1 * 1))`
6. `3 * (2 * 1)`
7. `3 * 2`
8. `6`

The recurse definition _diverges_ on integers < 0 (-1, -2), because the base case (`factorial 0`) is never reached:

```haskell
Main> factorial (-1)
Exception: stack overflow
```

### Why is Recursion Useful?

Some functions --such as `factorial`-- are _simpler_ to define in terms of other functions. Some are _naturally_ defined in terms of themselves.

## Recursion over Lists

```haskell
product       :: [Int] -> Int
product []     = 1
product (n:ns) = n * product ns
```

Or, `length`, in which the `head` is not relevant:

```haskell
length       :: [a] -> Int
length []     = 0
length (_:xs) = 1 + length xs
```

Recursive `reverse`:

```haskell
reverse       :: [a] -> [a]
reverse []     = []
reverse (x:xs) = reverse xs ++ [x]
```

## Multiple Arguments

```haskell
zip              :: [a] -> [b] -> [(a,b)]
zip []     _      = []
zip _      []     = []
zip (x:xs) (y:ys) = (x, y) : zip xs ys
```

## Quicksort

Definition:

1. The empty list is already sorted
2. Non-empty lists can be sorted by sorting the tail values =< the head and the tail values > the head, and then appending the resulting lists on the (correct) sides of the head value.

In the _correct_ version of the algorithm, you don't create newer lists, working on the existent one.

```haskell
qsort       :: [Int] -> [Int]
qsort     [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
   where
      smaller = [a | a <- xs, a <= x]
      larger  = [b | b <- xs, b > x]
```