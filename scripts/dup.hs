dup a = (a, a)

dupdup :: (a) -> ((((a), (a)), ((a), (a))), (((a), (a)), ((a), (a))))
dupdup  = dup . dup . dup

h    :: ((a -> b) -> a) -> ((a -> b) -> b)
--h g f = (f . g) $ f
h g f = f (g  f)

fix :: (a -> a) -> a
fix  = h fix

f :: (Eq a, Num a) => (a -> a) -> a -> a
f  = \f n -> if (n == 0) then 1 else n * f (n - 1)

k :: Integer -> Integer
k  = fix $ f
