# LEC-01 

## First Steps

The first thing is to watch [The Karate Kid](http://www.imdb.com/title/tt0087538/) (the original).

---

```haskell
Hugs> head [1..10]
1
Hugs> tail [1..10]
[2,3,4,5,6,7,8,9,10]
```

Haskell has index-zero:

```haskell
Hugs> [1..10] !! 2
3
Hugs> [1..10] !! 0
1
```

This is not idiomatic. List-indexing is too much _imperative programming_ mindset. More _wax-on-wax-off_ is required!

```haskell
Hugs> take 3 [1..10]
[1,2,3]
Hugs> take 13 [1..10]
[1,2,3,4,5,6,7,8,9,10]
```

`take` and `drop` are, basically, generalizations of `head` and `tail`.

```haskell
Hugs> take 3 [1..10]
[1,2,3]
Hugs> drop 3 [1..10]
[4,5,6,7,8,9,10]
```

`length` in a Haskel _List_ is different from the same function on an typical _Array_. It is a linear-time operation, ***not a constant-time operation*** like imperative counterparts.

Which means calculating `length` in bigger lists is more expensive.

```haskell
Hugs> length [1..10]
10
```

Appending _Lists_:

```haskell
Hugs> [1..3] ++ [4..10]
[1,2,3,4,5,6,7,8,9,10]
```

Composition:

```haskell
Hugs> sum (take 5 ([1..3] ++ [4..10]))
15
```

Breaking down:

```haskell
Hugs> [1..3] ++ [4..10]
[1,2,3,4,5,6,7,8,9,10]
Hugs> take 5 [1,2,3,4,5,6,7,8,9,10]
[1,2,3,4,5]
Hugs> sum [1,2,3,4,5]
15
```

## Haskell syntax compared to Math notation:

### Mathematical Notation:
`f(a, b) + c d` (space means multiplication)

### Haskell syntax:
`f a b + c*d`

Function notation is stronger than mathematical operations to: `f a + b` means _applies `f` to `a` ***then*** sums `b`_.

## Haskell Idioms

Haskell files have `.hs` suffix

In a file (`test.hs`):

```haskell
double x    = x + x
quadruple x = double (double x)
factorial n = product [1..n]
average ns  = sum ns `div` length ns
```

Notes: (1) x \`f\` y is *syntactic sugar* for `f x y`

Invoke `hugs` (or `ghci`) passing the test file:

```haskell
$ hugs script/test.hs

Hugs> double 10
20
Hugs> quadruple 10
40
Hugs> take (double 2) [1..20]
[1,2,3,4]
```

### Haskell naming conventions:

* Functions must begin with _lowercase_ letters: `average`, `balancedScore`, `calc_cart`
* Types begin with _uppercase_: `Integer`
* List arguments have a `s` suffix: `xs`, `ns`, `nss` _(list of lists)_
* Usually, Haskell elements are short (`x`) ***not*** `list_of_elements`

### Boolean logic operations

```haskell
Hugs> not True
False
Hugs> not False
True
Hugs> (not False || True) && (False || True)
True
Hugs> True || True && False
True
Hugs> (True || True) && False
False
Hugs> True || (True && False)
True
```

### String manipulation

```haskell
Hugs> "Hello" ++ " " ++ "world!"
"Hello world!"
Hugs> length "world"
5
Hugs> head "Hello"
'H'
Hugs> last "Hello"
'o'
Hugs> tail "Hello"
"ello"
Hugs> null "Hello"
False
Hugs> reverse "Hello"
"olleH"
```

### Type Errors

```haskell
Hugs> not "Hello"
ERROR - Type error in application
*** Expression     : not "Hello"
*** Term           : "Hello"
*** Type           : String
*** Does not match : Bool

Hugs> :t not
not :: Bool -> Bool

Hugs> :t True
True :: Bool
Hugs> :t "Hello"
"Hello" :: String
```

`not` expects `Bool` arguments. `"Hello"` is a `String`.

```haskell
Hugs> ['H', 'e', 'l', 'l', 'o']
"Hello"
Hugs> :t ['H', 'e', 'l', 'l', 'o']
['H','e','l','l','o'] :: [Char]
Hugs> :t 'H'
'H' :: Char
```

```haskell
Hugs> :t length
length :: [a] -> Int
```

The result is somewhat surprising.

The function returns an integer (i.e., an `Int`), ok. But it doesn’t take a string, i.e., a `[Char]`, but instead a `[a]`? What does the a mean?

It means that ***we don’t care!*** The `a` is a type variable. A type variable is a bit like a joker – we can choose any type to take `a`’s place! So length computes the length of any list – not just lists of characters, but also lists of numbers, or even lists of lists.

```haskell
Hugs> :t length
length :: [a] -> Int
Hugs> :t head
head :: [a] -> a
Hugs> :t tail
tail :: [a] -> [a]
```

All elements of a list must be of the same Type:

```haskell
Hugs> [True, "Hello"]

ERROR - Type error in list
*** Expression     : [True,"Hello"]
*** Term           : "Hello"
*** Type           : String
*** Does not match : Bool
```

The first element of the list was a `Bool`, so the type checker inferred that we’re writing a list of _Booleans_.

```haskell
Hugs> :t []
[] :: [a]
```

### Tuples

All elements in a list must have the same type. Not in _tuples_:

```haskell
Hugs> (1, "Hello")
(1,"Hello")
Hugs> :t (1, "Hello")
(1,"Hello") :: Num a => (a,[Char])
```

_Pairs_ are the more common _tuples_:

```haskell
Hugs> fst (1, "Hello")
1
Hugs> snd (1, "Hello")
"Hello"
Hugs> fst (1, 2, 3)

ERROR - Type error in application
*** Expression     : fst (1,2,3)
*** Term           : (1,2,3)
*** Type           : (a,b,c)
*** Does not match : (d,e)
```
---
