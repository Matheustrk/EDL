data Arvore = Folha | Galho Int Arvore Arvore
    deriving Show

arvore1 = Galho 7 (Galho 6 Folha Folha) (Galho 8  Folha (Galho 9 Folha Folha))

folhas :: Arvore -> Int
folhas Folha         = 1
folhas (Galho _ e d) = (folhas e) + (folhas d)

altura :: Arvore -> Int
altura Folha = 0
altura (Galho _ e d) = 
    if (altura e) > (altura d) 
        then (altura e) + 1
    else 
        (altura d) + 1

espelho :: Arvore -> Arvore
espelho Folha = Folha
espelho (Galho v e d) = Galho v (espelho d) (espelho e)

soma :: Arvore -> Int
soma Folha         = 0
soma (Galho v e d) = v + (soma e) + (soma d)

dobra :: Arvore -> Arvore
dobra Folha         = Folha
dobra (Galho v e d) = Galho (2*v) (dobra e) (dobra d)

possui :: Arvore -> Int -> Bool
possui Folha value         = False
possui (Galho v e d) value = (v == value) || (possui e value) || (possui d value)

--Binária de busca

possui_bin :: Arvore -> Int -> Bool
possui_bin Folha value  = False
possui_bin (Galho v e d) value = 
    if (value == v) then True
    else if (value <= v) then (possui_bin e value)
    else (possui_bin d value)    
    
maximo :: Arvore -> Int
maximo Folha         = -1
maximo (Galho v e d) =  
    case d of
        Folha -> v
        _     -> (maximo d)

insere :: Arvore -> Int -> Arvore
insere Folha value         = (Galho value Folha Folha) 
insere (Galho v e d) value = 
    if (value <= v) then Galho v (insere e value) d
    else Galho v e (insere d value)

main = do
    (print (soma arvore1))
    (print (dobra arvore1))
    (print (possui arvore1 8))
    (print (folhas arvore1))
    (print (altura arvore1))
    (print (espelho arvore1))
    (print (possui_bin arvore1 5))
    (print (maximo arvore1))
    (print (insere arvore1 4))

