import Prelude hiding (Maybe (..))

data Maybe a = Nothing | Just a deriving Show

-- answer b
instance Monad Maybe where
    return x = Just x
    Nothing >>= _ = Nothing
    (Just x) >>= f = f x


-- (Just 3) >>= (return . double)
double x = x*2

---- answer c
--instance Monad Maybe where
--    return x = Just x
--    Nothing >>= _ = Nothing
--    (Just x) >>= f = Just (f x)
