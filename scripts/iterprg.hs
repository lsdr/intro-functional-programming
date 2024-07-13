putStr' []     = return ()
putStr' (x:xs) = putChar x >> putStr' xs

putStrLn' [] = putChar '\n'
putStrLn' xs = putStr' xs >> putChar '\n'

getLine' = getc []

getc :: String -> IO String
getc xs = do x <- getChar
             case x of
                 '\n' -> return xs
                 _ -> getc (xs ++ [x])


interact' f = do input <- getLine'
                 putStrLn' (f input)

