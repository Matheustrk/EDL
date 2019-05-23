data Exp = Num Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
         | Div Exp Exp
         deriving Show

avalia :: Exp -> Int
avalia (Num v) = v
avalia (Add a b) = (avalia a) + (avalia b)
avalia (Sub a b) = (avalia a) - (avalia b) 
avalia (Mul a b) = (avalia a) * (avalia b) 
avalia (Div a b) = (avalia a) `div` (avalia b) 

avalia' :: Exp -> Exp
avalia' (Num v) = (Num v)
avalia' (Add (Num a) (Num b)) = Num (a + b)
avalia' (Sub (Num a) (Num b)) = Num (a - b)
avalia' (Mul (Num a) (Num b)) = Num (a * b)
avalia' (Div (Num a) (Num b)) = Num (a `div` b)
avalia' (Add a b)             = (avalia' (Add (avalia' a) (avalia' b)))
avalia' (Sub a b)             = (avalia' (Sub (avalia' a) (avalia' b)))
avalia' (Mul a b)             = (avalia' (Mul (avalia' a) (avalia' b)))
avalia' (Div a b)             = (avalia' (Div (avalia' a) (avalia' b)))


main = print(avalia' (Div (Sub (Num 1) (Num 2)) (Sub (Num 3) (Num 4))))
