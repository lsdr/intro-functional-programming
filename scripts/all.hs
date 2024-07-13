sumsqreven = compose [sum, map (^2), filter, even]

compose = foldr (.) id

--dec2int = foldr (\ x y -> 10*x + y) 0
--dec2int = foldl (\ x y -> x + 10*y) 0
dec2int = foldl (\ x y -> 10*x + y) 0
--dec2int = foldr (\ x y -> x + 10 * y) 0


-- filter' p = foldl (\ xs x -> if p x then x : xs else xs) []
-- filter' p = foldr (\ x xs -> if p x then x : xs else xs) []
filter' p = foldr (\ x xs -> if p x then xs ++ [x] else xs) []
--filter' p = foldl (\ x xs -> if p x then xs ++ [x] else xs) []


-- map' f = foldr (\ x xs -> xs ++ [f x]) []
-- map' f = foldr (\ x xs -> f x ++ xs) []
-- map' f = foldl (\ xs x -> f x : xs) []
map' f = foldl (\ xs x -> xs ++ [f x]) []


-- all p xs = and (map p xs)

-- any p = map p . or
-- any p = or . map p
-- any p xs = length (filter p xs) > 0
-- any p = not . null . dropWhile (not . p)
-- any p = null . filter p
-- any p xs = not (all (\x -> not (p x)) xs)
-- any p xs = foldr (\ x acc -> (p x) || acc) False xs
-- any p xs = foldr (||) True (map p xs)

curry f = \ x y -> f x y
curry f = \ x y -> f
curry f = \ x y -> f x y
curry f = \ x y -> f x y
