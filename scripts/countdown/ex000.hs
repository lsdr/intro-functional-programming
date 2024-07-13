subs                          :: [a] -> [[a]]
subs []                       =  [[]]
subs (x:xs)                   =  yss ++ map (x:) yss
                                 where yss = subs xs

interleave                    :: a -> [a] -> [[a]]
interleave x []               =  [[x]]
interleave x (y:ys)           =  (x:y:ys) : map (y:) (interleave x ys)

perms                         :: [a] -> [[a]]
perms []                      =  [[]]
perms (x:xs)                  =  concat (map (interleave x) (perms xs))

choices                       :: [a] -> [[a]]
choices                       =  undefined

-- answer a
choicesa xs = [ys ++ zs | ys <- subs xs, zs <- perms xs]

-- answer b
choicesb xs = concat [zs | ys <- subs xs, zs <- perms ys]

-- answer c
-- THIS ONE
choicesc xs = [zs | ys <- subs xs, zs <- perms ys]

-- answer d
choicesd xs = [zs | ys <- perms xs, zs <- subs ys]

