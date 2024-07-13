-- original statement
class Monoid a where
    mempty :: a
    (<>) :: a -> a -> a

instance Monoid [a] where
    mempty = []
    (<>) = (++)
