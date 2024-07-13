# LEC-07

_Functional Parsers_

No one can follow the path towards mastering functional programming without writing their own parser combinator library.

We start by explaining what parsers are and how they can naturally be viewed as side-effecting functions. Next we define a number of basic parsers and higher-order functions for combining parsers. 

## What is a Parser?

A _parser_ is a program that analyses a piece of text to determine its _syntatic structure_.


### The `Parser` Type

In a functional language such as Haskell, parsers can naturally be viewed as _functions_.

```haskell
type Parser = String -> Tree
```

A parser is a function that takes a `String` and returns some form of `Tree`.

This is a bit restrict, we can generalize to make it easier to write the parser:

```haskell
type Parser a = String -> [(a, String)]
```

* The parser may not be able to parse the whole string, so returning the part that was not processed is a good thing;
* A string might be _parseable_ in many ways, so generalizing to a `List` of results is a good approach;
* The _output_ can be more than a `Tree`, so parameterizing the `Parser` passing the _output_ `a` is also nice.

(the course will only use simple parsers, that either _fail_ to an empty `List` or _succeed_ and return a _singleton list_.

## Basic Parsers

To create a complicated parser, first we create a set of simple parsers.

The first one parses and extracts a _single_ `Char`. `item` fails to an empty `List`, otherwise consumes the first `Char` of the `List`:

```haskell
item :: Parser Char
item  = \inp -> case inp of
                  []     -> []
                  (x:xs) -> [(x, xs)]
```

`failure` is a parser that "always fails", returning an empty `List`:

```haskell
failure :: Parser a
failure  = \inp -> []
```

And its opposite, `return`, is a parser that "always succeeds":

```haskell
return  :: a -> Parser a
return v = \inp -> [(v, inp)]
```

The `p +++ q` behaves as the parser `p` if it succeeds, otherwise as the parser `q`:

```haskell
(+++)  :: Parser a -> Parser a -> Parser a
p +++ q = \inp -> case p inp of
                    [] -> parse q inp
                    [(v, out)] -> [(v, out)]
```

`parse` applies the parser to a `String`:

```haskell
parse      :: Parse a -> String -> [(a, String)]
parse p inp = p inp
```

### Running out parsers

```haskell
Main> parse item ""
[]

Main> parse item "abc"
[('a', "bc")]

Main> parse failure "abc"
[]

Main> parse (return 1) "abc"
[(1, "abc")]

Main> parse (item +++ return 'd') "abc"
[('a', "bc")]

Main> parse (failure +++ return 'd') "abc"
[('d', "bc")]
```

### Notes of Interest

* The `Parser` type is a _monad_.

## Sequencing

A sequence of parsers can be combined as a single _composite parser_ using the keyword `do`, for example:

```haskell
p :: Parser (Char, Char)
p  = do x <- item
        item
        y <- item
        return (x, y)
```
(the above example is ilustrative. It raises exception when compiled)

* The values returned by intermediate parsers are _discarted_, unless if named using the `<-` operator,
* The value returned by the _last_ parser is the value returned by the _sequence_,
* If any parser in a sequence _fails_, then the _whole sequence fails_,
* The `do` notation is not specific to the `Parser` type, but can be used with _any_ monadic type, this is a big deal-- not just sounding _smart_ or something.

## Derived Primitives

Parsing a character that _satisfies_ a predicate:

```haskell
sat  :: (Char -> Bool) -> Parser Char
sat p = do x <- item
           if p x then
              return x
           else
              failure
```
See `parsing.lhs` for more functions.

```haskell
string       :: String -> Parser String
string []     = return []
string (x:xs) = do char x
                   string xs
                   return (x:xs)
```
### Examples

```haskell
p :: Parser String
p  = do char '['
        d  <- digit
        ds <- many (do char ',' digit)
        char ']'
        return (d:ds) 
```

Thus:

```haskell
Main> parse p "[1, 2, 3, 4]"
[("1234", "")]
```

## Arithmetic Expressions

With the parsers we have from the previous two-parts of this lecture (see `parsing.lhs`), we can parse and process basic arithmetics.

### Basic Grammar

```
expr    => term ('+' expr | term )
term    => factor ('*' term | factor)
factor  => digit | '(' expr ')'
digit   => '0' | '1' | ... | '9'
```

### Basic Implementation

#### Implementing `expr`
```haskell
expr :: Parser Int
expt  = do t <- term
           do char '+'
              e <- expr
              return (t + e)
           +++ return t        
```

#### Implementing `term`
```haskell
term :: Parser Int
term  = do f <- factor
           do char '*'
              t <- term
              return (f + t)
           +++ return f    
```

#### Implementing `factor`
```haskell
factor :: Parser Int
factor  = do d <- digit
             return (digitToInt d)
          +++ do char '('
                 e <- expr
                 char ')'
                 return e
```

This set of _parsers_ work like a Internal DSL; allowing to do some parsing without having to use `lex` or `yacc`.

#### Implementing `eval`
```haskell
eval   :: String -> Int 
eval xs = fst (head (parse expr xs))
```
Running it:

```haskell
> eval "2*3+4"
10

> eval "2*(3+4)"
14
```