# Rust
![Rust](https://upload.wikimedia.org/wikipedia/commons/d/d5/Rust_programming_language_black_logo.svg)

## Introdução
Rust é uma nova linguagem desenvolvida pela Mozilla juntamente com uma comunidade de voluntários. A linguagem apareceu como um projeto pessoal de Graydon Hoare, empregado da Mozilla, e foi projetada para ajudar desenvolvedores a criarem aplicações rápidas e seguras. Rust vem como alternativa para linguagens como C/C++, D e Go.

## Origens e Influências
Rust é fortemente influenciada por Cyclone com alguns aspectos de orientação a objetos de c++. Além disso, inclui características funcionais de linguagens como Haskell e OCaml.

![familytree](https://5b0988e595225.cdn.sohucs.com/images/20180731/ebd0b140415944dfa019ab257473b6e7.png)

## Classificação
- Multiparadigma
- Compilada
- Tipagem estática e Inferência de tipo 

## Avaliação Comparativa entre Rust e C/C++

#### Pattern Match: Verificar a presença de um padrão dado um conjunto de dados qualquer.
#### Objetivo do programa: Dado uma estrutura que define cores, de forma variada, tomar uma decisão em todos os casos possíveis

### Rust
  ```rust
enum Color{
    Red,
    Green,
    Blue,
    RgbColor(u8, u8, u8),
    Cmyk{cyan:u8, magenta:u8, yellow:u8, black:u8}
}
fn main(){

    let c:Color = Color::RgbColor(1,100,255);
    match c {
        Color::Red => println!("r"),
        Color::Green => println!("g"),
        Color::Blue => println!("b"),
        Color::RgbColor(0,0,0) => println!("black"),
        Color::RgbColor(r, g, b) => println!("rgb({},{},{})", r, g, b),
        Color::Cmyk{cyan:_,magenta:_,yellow:_,black:255} => println!("black"),
        _ => ()
    }
}
  ``` 

```c
#include <stdio.h>
union Color {
    enum {
    C_primaria, C_RGB, C_CMYK
    } ctype;

    enum cores_primarias {
        Red,
        Yellow,
        Blue
    }cor_primaria;

    struct RgbColor {
        int r;
        int g;
        int b;
    }RGB;

    struct Cmyk {
    int cyan;
    int magenta;
    int yellow;
    int black;
    }CMYK;

};

int main(void){
    union Color color;
    color.RGB.r = 1;
    color.RGB.g = 100;
    color.RGB.b = 255;
    color.ctype = 1;
    switch (color.ctype)
    {
        case C_primaria:
            switch (color.cor_primaria)
            {
                case Red:
                    printf("RED");
                    break;
                case Yellow:
                    printf("Yellow");
                    break;
                case Blue:
                    printf("Blue");
                    break;
            }
        case C_RGB:
            if(color.RGB.r == 0 && color.RGB.g == 0 && color.RGB.b == 0){
                printf("BLACK");
            }
            else
                printf("%d %d %d",color.RGB.r,color.RGB.g,color.RGB.b);
            break;
        case C_CMYK:
            if(color.CMYK.cyan == 0 && color.CMYK.magenta == 0 && color.CMYK.yellow == 255 && color.CMYK.black == 0){
                printf("YELLOW");
            }
            break;

        default:
            printf("");
            break;
    }
    return 0;
}
``` 

### Análise
O pattern matching obriga o programador a cobrir todas as possibilidades (verificadas em tempo de compilação) além de conter diversos açucares sintáticos. Rust expressa tudo isso pela keyword match. Em c observamos a não existencia, nativa, tanto de pattern match quanto do Tagged Union, dificultando a sua implementação.É necessário forçar o encadeamento de switches e if's forçando o programador a garantir a cobertura das possibilidades.


## Conclusão
Rust é uma nova linguagem que oferece diversos benefícios em relação as suas "concorrentes". Foi considerada pelo público a linguagem "mais amada" por três anos consecutivos, de acordo com uma pesquisa conduzida pelo site Stack Overflow em 2016, 2017 e 2018 e está entre as 25 linguagens mais populares, de acordo com uma pesquisa conduzida pela RedMonk. Portanto, Rust vem com uma proposta interessante, atraindo cada vez mais adeptos.