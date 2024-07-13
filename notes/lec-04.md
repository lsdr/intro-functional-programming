# LEC-04

List comprehensions allow many functions over lists to be defined in a very concise manner.

We start by explaining generators and guards, introduce the function zip and conclude with the notion of string comprehensions.

In _math_, the _comprehension_ notation can be used to construct new sets from old sets:

## List Comprehensions

Derived from _math_ Set Comprehension:

```haskell
{ x^2 | x in {1...5} }
```
Written as a Haskel _List Comprehension_:

```haskell
Main> [x^2 | x <- [1..5]]
[1,4,9,16,25]
```

The `x <- [1..5]` is called a ___generator___. A comprehension can have multiple generators (separated by commas):

```haskell
Main> [(x,y) | x <- [1,2,3], y <- [4,5]]
[(1,4),(1,5),(2,4),(2,5),(3,4),(3,5)]

Main> [(x,y) | y <- [4,5], x <- [1,2,3]]
[(1,4),(2,4),(3,4),(1,5),(2,5),(3,5)]
```

**NOTE:** Switching the position of `x` and `y` in the comprehension alters the output vector. Works like a _nested loop_.

### Dependent Generators

Later _generators_ can depend on the variables that are introduced by earlier generators:

```haskell
Main> [(x,y) | x <- [1..3], y <- [x..3]]
[(1,1),(1,2),(1,3),(2,2),(2,3),(3,3)]
```

A practical example: a _function_ that concatenates a `List` of _lists_ can be written as this:

```haskell
concat    :: [[a]] -> [a]
concat xss = [x | xs <- xss, x <- xs]
```
This is a _loop_ of _loops_! The _outer loop_ (`xs <- xss`) iterate over each list inside de list of lists and the _inner loop_, iterates over each item inside the current list, returning each element.

### Guards

Guards can filter (or restrict) values produced by earlier generators:

```haskell
Main> [x | x <- [1..10], even x]
[2,4,6,8,10]
```

### String Comprehensions

```haskell
lowers xs = length [x | x <- xs, isLower x]
```