data Arvore = Folha | Galho Arvore Arvore
    deriving Show

arvore1 = Galho (Galho (Galho Folha Folha) Folha) (Galho Folha Folha)

folhas :: Arvore -> Int
folhas Folha = 1
folhas (Galho e d) = (folhas e) + (folhas d)

altura :: Arvore -> Int
altura Folha = 0
altura (Galho e d) = 
    if (altura e) > (altura d) 
        then (altura e) + 1
    else 
        (altura d) + 1

espelho :: Arvore -> Arvore
espelho Folha = Folha
espelho (Galho e d) = Galho (espelho d) (espelho e)
    
main = do
    (print (folhas arvore1))
    (print (altura arvore1))
    (print (espelho arvore1))