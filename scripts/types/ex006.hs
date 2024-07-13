data Tree = Leaf Integer | Node Tree Tree deriving Show

halve xs = splitAt (length xs `div` 2) xs

balance :: [Integer] -> Tree
balance [x] = Leaf x
balance xs = Node (balance ys) (balance zs)
    where (ys, zs) = halve xs
