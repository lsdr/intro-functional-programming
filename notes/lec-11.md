# LEC-11

_Lazy Evaluation_

## Introduction

How Haskell _really_ evaluate expressions. Let's look in detail.

Haskell uses a simple technique that, among other thing:

1. Avoids doing _unnecessary evaluation_
2. Allows programs to be _more modular_
3. Allows us to program with _infinite lists_

The evaluation technique is called _lazy evaluation_ and Haskell is a _lazy functional language_.

## Evaluating Expressions

Basically, expressions are evaluated (or _reduced_) by successively _applying definitions_ until no further simplification is possible.

For example, given `square n = n * n`

The expression `square(3 + 4)` can be evaluated using the following sequence of reductions:

### The Imperative Way

```
  square (3 + 4)
=
  square 7
=
  7 * 7
=
  49
```

### The Lazy Way

```
  square (3 + 4)
=
  (3 + 4) * (3 + 4)
=
  7 * (3 + 4)
=
  7 * 7
=
  49
```

Now we have applied _square_ before doing the addition, but the final result is the same.

#### A quick note about _side effects_

Both strategies for evaluting the code works and leads us to the _same result_ ***because*** Haskell is a pure language, _free of side-effects_.

In a language that have (or worse, encorages) side-effects, this probably would not be true. And that's because side-effects could change the result of the evalution given a context, and thus leading to different --and possibly wrong-- results.

> **FACT**: In [Haskell](https://wiki.haskell.org), two _different_ (but _terminating_) ways of evaluation _the same_ expression will always give _the same_ final result.

### Reduction Strategies

Each stage during evaluation, there may be _many_ possible subexpressions that can be reduced.

The two common strategies for deciding with _redex_ (**red**ucible sub**ex**pression) to choose are:

1. Innermost reduction: An innermost redex is always reduced
2. Outermost reduction: An outermost redex is always reduced

How we compare both strategies?

### Termination

Given `loop = tail loop`, will eval the expression `fst (1, loop)` using the two strategies.

#### Innermost reduction

```
  fst (1, loop)
=
  fst (1, tail loop)
=
  fst (1, tail (tail loop))
=
  ...
```

This strategy _does not terminate_.

#### Outermost reduction

```
  fst (1, loop)
=
  1
```

***Oh shit!*** It _nailed_ the expression with just _one step_!

#### Facts about Outermost reduction

* Outermost reduction may give a result when innermost reduction _fails to terminate_
* For a given expression, if there exists _any_ reduction sequence that terminates, then outermost reduction _also_ terminates, with the _same result_
* Outermost reduction _may require more steps_ than the innermost reduction (remember the `square` example)

### Sharing

Using _pointers_ to indicate _sharing_ of expressions during evaluation, we can reduce problems such as evaluating `(3 + 4)` twice.

We evaluate it only once and where the expression is duplicated, _pointers are used instead_.

## Definition of Lazy Evaluation

> Lazy Evaluation = Outermost reduction + sharing

### Facts about Lazy Evaluation

1. _Never_ requires more steps than innermost reduction
2. Haskell uses _lazy evaluation_

### Infinite Lists

Consider the following definition

```haskell
ones :: [Int]
ones  = 1 : ones
```

Unfolding the recursion:

```haskell
ones = 1 : ones
     = 1 : 1 : ones
     = 1 : 1 : 1 : ones
     ...
```

That's an infinite list, alright. Now, consider evaluation the expression `head ones` using _innermost reduction_ and _lazy evaluation_.

#### Innermost reduction

```haskell
head ones = head (1 : ones)
          = head (1 : 1 : ones)
          = ...
```

And... _does not terminate_

#### Lazy evaluation

```haskell
head ones = head (1 : ones)
          = 1
```

### So...

> Using lazy evaluation, expressions are only evaluated as _much as required_ to produce the final result.

Thus, `ones = 1 : ones` only defines a _potentially infinite_ list that is only evaluated _as much as required_ by the context in which it is used.

### Modular Programming

Lazy evaluation allows us to make more _modular programs_, separating the ***control*** and the ***data***:

```haskell
?> take 5 [1..]
```

* `take 5` is the ***control***
* `[1..]` is the ***data***

Although the ***data*** is a _potentially infinite_ list, we only evaluate as much as required by the ***control*** part of the expression.

> This also answers a long-time question I had about Python and _why_ functions like `map` received the _function_ first and than the _data_. It's all about ***control-data***.
