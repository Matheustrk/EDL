# Rust

![Rust](https://upload.wikimedia.org/wikipedia/commons/d/d5/Rust_programming_language_black_logo.svg) 
![ferris](https://avatars1.githubusercontent.com/u/14631472?s=200&v=4)

Este artigo falará um pouco sobre a linguagem de programação Rust. Ela promete **performance** já que tenta manter todas as verificações em tempo de compilação, na lista de grandes vantagens está também o aumento de **produtividade**, já que possui uma ótima documentação além de um compilador com mensagens bem úteis e não menos importante o sistema de ownership que dentre várias utilidades está principalmente o gerenciamento de memória. 

Essa Linguagem foi projetada para ajudar desenvolvedores a criarem aplicações rápidas e seguras. Rust vem como alternativa para linguagens como C/C++, D e Go.

## História

A linguagem foi projetada por Graydon Hoare, empregado da Mozilla, e em 2009 ela a organização começou a apoiar o projeto.
A primeira versão (pré-alfa) foi lançada em 2012 e a primeira versão estável foi lançada em **15 de Maio de 2015**.

### Influências 
Rust é fortemente influenciada por Cyclone com alguns aspectos de orientação a objetos de c++. Além disso, inclui características funcionais de linguagens como Haskell e OCaml.

![familytree](https://5b0988e595225.cdn.sohucs.com/images/20180731/ebd0b140415944dfa019ab257473b6e7.png)

## Sobre a linguagem
Abaixo estão algumas características da liguagem Rust:
* **Inferência de Tipo:** O programador pode deixar o compilador inferir o tipo no tempo de compilação ou ele memo definir na criação da variável. Abaixo mostra as duas possibilidades:
```rust
    let i = 20; // Isso será inferido pelo compilador como um inteiro 32bits
    let i : i32 = 20; // No momento de criação da variável o programador já definiu o tipo da mesma

``` 

* **Tagged union nativo:** O programador pode criar enums que podem guardar valores diferentes, não apenas números. No caso mostrado abaix criamos um enum Color que guarda valores diferentes para cada tipo definido no Enum:
```rust
   enum Color {
        Red,
        Blue,
        Green,
        RGB(u32, u32, u32),
        HSV(u32, u32, u32),
        HSL(u32, u32, u32),
        CMY(u32, u32, u32),
        CMYK(u32, u32, u32, u32),
    }

``` 

* **Orientada a objetos:** Rust permite um estilo de programação voltada para orientação à objetos.
Abaixo Criamos uma struct chamada **AveragedCollection** e logo depois implementamos funções que apenas dados deste tipo podem usar.
```rust
    pub struct AveragedCollection {
        list: Vec<i32>,
        average: f64,
    }

    impl AveragedCollection {
        pub fn add(&mut self, value: i32) {
            self.list.push(value);
            self.update_average();
        }

        pub fn remove(&mut self) -> Option<i32> {
            let result = self.list.pop();
            match result {
                Some(value) => {
                    self.update_average();
                    Some(value)
                },
                None => None,
            }
        }

        pub fn average(&self) -> f64 {
            self.average
        }

        fn update_average(&mut self) {
            let total: i32 = self.list.iter().sum();
            self.average = total as f64 / self.list.len() as f64;
        }
    }
``` 

*  **Funcional:** Rust permite um estilo de programação funcional.
```rust
    let closure_soma10 = |num: u32| -> u32 {
        num + 10
    };
``` 

*  **Compilador:** O compilador é uma das grandes maravilhas do Rust e o porque é bem simples: Ele foi desenvolvido para encontrar a maioria dos problemas que causam malfuncionamento do programa em tempo de compilação e também tornar os erros do compilador mais inteligíveis para os programadores. Muitas vezes o próprio compilador dá dicas de como arrumar alguma parte do código que ele não gostou muito.
E graças ao compilador e ao sistema de ownership que falaremos mais adiante que torna o rust uma linguagem estremamente rápida em questão de performance, porque muito pouco é feito em runtime. Temos maior segurança com os programs desenvolvidos nessa linguagem porque o compilador faz muitas checagem. Segue um exemplo do nosso querido compilador em ação:
```rust
    let example_closure = |x| x;

    let s = example_closure(String::from("hello"));
    let n = example_closure(5);
```
```text
error[E0308]: mismatched types
 --> src/main.rs
  |
  | let n = example_closure(5);
  |                         ^ expected struct `std::string::String`, found
  integral variable
  |
  = note: expected type `std::string::String`
             found type `{integer}`
```

*  **Ownership:**
    * Grande diferença do Rust para as demais linguagens. Rust possui uma abordagem bem diferente das demais linguagens, não é usado nenhum algorítmo de garbage collector como Java nem depende do programador para ficar gerenciando a memória como é feito em C.
    * Esse novo método é baseado nas regras abaixo:
        * Todo valor em Rust possui uma variável que é sua dona.
        * Só pode existir um dono por vez.
        * Quando o dono sai do escopo o valor será liberado da memória.

## Expressividade em relação à linguagem C/C++
Como a linguagem Rust veio para competir no mercado com as linguagens C e C++, então faremos um comparativo de expressividades entre elas.
Falaremos sobre dois tópicos: **Ownership** e **Pattern Matching**.

### Ownership

A melhor forma de entender como essa abordagem funciona é com um exemplo. Vale lembrar que em rust cada conjunto de código entre chaves ({}) são chamados blocos. Segue um desses blocos abaixo:
```rust
    { // A variável s não existe nesse momento
        let s = "hello";   // Agora s é valida

        // Já que s é valida podemos fazer o que quisermos com ela
    } // Agora s saiu do escopo e portando não é mais válida.
```

Com o exemplo acima podemos ver a **Terceira** e a **Primeira** regra do ownership em ação. A variável só existe dentro do escopo.

Agora um outro exemplo da **Segunda** regra do ownership:
```rust
    let s1 = String::from("hello"); // Criamos uma String e a dona dela é s1
    let s2 = s1; //Agora movemos o valor de s1 para s2 e portanto o novo dono é s2 e s1 não poderá mais ser usada enquanto o ownership não voltar para ela
```

Como podemos ver, as regras do ownership funcionam sem a intervenção do programador e nem precisa de um garbage collector esperando avidamente por algum espaço da memória para ser limpo.

Vale ressaltar que o sistema de ownsership também torna seguro programação concorrente justamente devido às 3 regras citadas acima.

Como podemos notar , o gerenciamento de memória é feito de forma eficaz e sem precisar do programador ficar cuidando disso como é normalmente feito em C/C++.

Vale ressaltar que regras do ownership devem estar na cabeça do programador na hora de fazer desenvolvimentos porque algumas vezes o que ele acha que está acontecendo na realidade não.

### Pattern Matching

 Pattern Matching significa verificar a presença de um padrão dado um conjunto de dados qualquer.

#### Objetivo do programa: Dado uma estrutura que define cores, de forma variada, tomar uma decisão em todos os casos possíveis

### **Rust**
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
### **C**
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

O pattern matching obriga o programador a cobrir todas as possibilidades (verificadas em tempo de compilação) além de conter diversos açucares sintáticos. Rust expressa tudo isso pela keyword match. Em c observamos a não existencia, nativa, tanto de pattern match quanto do Tagged Union, dificultando a sua implementação.É necessário forçar o encadeamento de switches e if's forçando o programador a garantir a cobertura das possibilidades.

## Conclusão
Rust é uma nova linguagem que oferece diversos benefícios em relação as suas "concorrentes". Foi considerada pelo público a linguagem "mais amada" por três anos consecutivos, de acordo com uma pesquisa conduzida pelo site Stack Overflow em 2016, 2017 e 2018 e está entre as 25 linguagens mais populares, de acordo com uma pesquisa conduzida pela RedMonk. Portanto, Rust vem com uma proposta interessante, atraindo cada vez mais adeptos.

## Bibliografia e Links
* Site oficial: https://www.rust-lang.org/
* Página com referências oficiais para aprendizado: https://www.rust-lang.org/learn
* Wikipédia: https://en.wikipedia.org/wiki/Rust_(programming_language)
* Compilador online oficial: https://play.rust-lang.org/