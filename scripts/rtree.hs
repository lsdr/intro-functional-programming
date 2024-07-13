data Tree a = Leaf
            | Node (Tree a) a (Tree a) deriving Show


{- repeatTree_a x = Node x x x -}

repeatTree_b x = Node t x t
  where t = repeatTree_b x

{- repeatTree_c x = repeatTree_c (Node Leaf x Leaf) -}

{- repeatTree_d x = Node t x t -}
  {- where t = repeatTree_d (Node t x t) -}
