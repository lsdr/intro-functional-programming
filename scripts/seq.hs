-- answer a

-- answer b
sequence_'b [] = return ()
sequence_'b (m : ms) = (foldl (>>) m ms) >> return ()

-- answer c
sequence_'c ms = foldl (>>) (return ()) ms

-- answer d
sequence_'d [] = return ()
sequence_'d (m : ms) = m >> sequence_'d ms

-- answer e
sequence_'e [] = return ()
sequence_'e (m : ms) = m >>= \_ -> sequence_'e ms

-- answer f

-- answer g
sequence_'g ms = foldr (>>) (return ()) ms

-- answer h

-- ----
-- answer a
sequence'a [] = return []
sequence'a (m : ms)
  = m >>=
    \ a ->
      do as <- sequence'a ms
         return (a : as)

-- answer b
{- sequence'b ms = foldr func (return ()) ms -}
    {- where -}
        {- func :: (Monad m) => m a -> m [a] -> m [a] -}
        {- func m acc = do x <- m -}
                        {- xs <- acc -}
                        {- return (x : xs) -}

-- answer c
{- sequence'c ms = foldr func (return []) ms -}
    {- where -}
        {- func :: (Monad m) => m a -> m [a] -> m [a] -}
        {- func m acc = m : acc -}

-- answer d
{- sequence'd [] = return [] -}
{- sequence'd (m : ms) = return (a : as) -}
    {- where -}
        {- a <- m -}
        {- as <- sequence'd ms -}

-- answer e
sequence'e ms = foldr func (return []) ms
    where
        func :: (Monad m) => m a -> m [a] -> m [a]
        func m acc = do x <- m
                        xs <- acc
                        return (x : xs)

-- answer f
{- sequence'f [] = return [] -}
{- sequence'f (m : ms) = m >> \a -> -}
    {- do as <- sequence'f ms -}
       {- return (a : as) -}

-- answer g
{- sequence'g [] = return [] -}
{- sequence'g (m : ms) = m >>= \a -> -}
    {- as <- sequence'g ms -}
    {- return (a : as) -}

-- answer h
sequence'h [] = return []
sequence'h (m : ms) = do a <- m
                         as <- sequence'h ms
                         return (a : as)

