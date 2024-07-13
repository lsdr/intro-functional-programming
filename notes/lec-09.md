# LEC-09

_Declaring Types and Classes_

## Type Declaration

In Haskell, a new name for an existing type can be defined using a _type declaration_:

```haskell
-- String as an alias for List of Chars
type String = [Char]
```

This is useful to convey the meaning, or intent, of what the program do. Example:

```haskell
type Pos = (Int, Int)
```
We defined a new _type_ `Pos` to represent a position in a 2D plane. As a consequence, instead of writing `(Int, Int)` everywhere, `Pos` is used and it's more semantic thus better for reading/comprehending:

```haskell
origin :: Pos
origin  = (0, 0)

left       :: Pos -> Pos
left (x, y) = (x-1, y)
```

A type declaration can also be parameterized:

```haskell
type Pair a = (a, a)
```

Allowing us to define functions as:

```haskell
copy       :: a -> Pair a
copy x      = (x, x)

mult       :: Pair Int -> Int
mult (m, n) = m*n
```

This type declarations are just _synonyms_, thus cannot be recursive. This, for instance, would not work:

```haskell
type Tree = (Int, [Tree])
```

It is possible to do something like that, but it requires something called "Nominal Types".

## Data Declarations

A completely _new_ type can be defined by specifying its values using a _data declaration_:

```haskell
-- Bool is a new type, with two constructors: False and True
-- (also values, since both constructors don't take params)
data Bool = False | True
```
* The two values `False` and `True` are called _constructors_ for the type `Bool`
* Data declarations are similar to _context free grammars_. The former specifies the values of a type and the latter the sentences of a language.

### The `Answer` data type

```haskell
data Answer = Yes | No | Unknown
```
With this, we can define functions like:

```haskell
answers     :: [Answer]
answers      = [Yes, No, Unknown]

flip        :: Answer -> Answer
flip Yes     = No
flip No      = Yes
flip Unknown = Unknown
```
Constructors can also receive parameters:

```haskell
data Shape = Circle Float
           | Rect Float Float
```

Checking types with `:t` returns:

```haskell
Circle :: Float -> Shape
Rect   :: Float -> Float -> Shape
```
Both return a `Shape`, but `Circle` constructor needs only one param while `Rect` needs two.

## Recursive Types

In Haskell, new types can be declared recursively:

```haskell
data Nat = Zero
         | Succ Nat
```

`Nat` being a _new_ type, with constructors `Zero :: Nat` and `Succ :: Nat -> Nat`. All the values of `Nat` are either `Zero` or of the form `Succ n` -- that is, `Nat` contains de following infinite sequence:

```haskell
Zero
Succ Zero
Succ (Succ Zero)
...
```

Thus `Succ (Succ (Succ Zero))` represents the natural number `3`:

```haskell
1 + (1 + (1 + 0)) = 3
```

It is possible to define a `add` function:

```haskell
add Zero n     = n
add (Succ m) n = Succ (add m n)
```

And doing a sum like: `add (Succ (Succ Zero)) (Succ Zero)`, and it would _push_ de `add` inside and it would go like:

```haskell
> add (Succ (Succ Zero)) (Succ Zero)
> Succ (add (Succ Zero) (Succ Zero))
> Succ (Succ (add Zero (Succ Zero))
> Succ (Succ (Succ Zero))
> 3
```

