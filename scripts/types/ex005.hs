data Tree = Leaf Integer | Node Tree Tree deriving Show

leaves           :: Tree -> Integer
leaves (Leaf _)   = 1
leaves (Node l r) = leaves l + leaves r

balanced           :: Tree -> Bool
balanced (Leaf _)   = True
balanced (Node l r) = abs (leaves l - leaves r) <= 1 && balanced l && balanced r

