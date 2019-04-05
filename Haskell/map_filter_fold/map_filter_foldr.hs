type Autores = [String]
type Musica = (String, Int, Int)
bandas :: [Autores]
bandas = [ ["Gilberto Gil"], ["Victor", "Leo"], ["Gonzagao"], ["Claudinho", "Bochecha"] ]
musicas :: [Musica]
musicas = [ ("Aquele Abraco", 1, 100),("Esperando na Janela", 1, 150),("Borboletas", 2, 120),("Asa Branca", 3, 120),("Assum Preto", 3, 140),("Vem Morena", 3, 200),("Nosso Sonho", 4, 150),("Quero te Encontrar", 4, 100) ]

--Somente o nome da músicas:
so_musica :: Musica -> String
so_musica (musica,_,_) = musica
ex1 = map so_musica musicas

--Somente músicas com >= 2min:
maior2 :: Musica -> Bool
maior2 (_,_,tempo) = 
    if tempo>=120 
    then 
        True
    else
        False
ex2 = filter maior2 musicas

--Maior duração:
maior_duracao :: Musica -> Int -> Int
maior_duracao (_,_,duracao) duracao_atual =  
    if duracao > duracao_atual 
    then 
        duracao
    else 
        duracao_atual
ex3 = foldr maior_duracao 0 musicas

--Nomes com >= 2min:
ex4 = map so_musica (filter maior2 musicas)

--Pretty-print música:
--WIP

main = return()