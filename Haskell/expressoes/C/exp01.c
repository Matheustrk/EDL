#include <stdio.h>

typedef struct exp Exp;
enum tipoExpressao { Num, Add, Sub };

struct exp {
    enum tipoExpressao tipo;
    union {
        int Num;    
        struct { Exp *exp_ADD1, *exp_ADD2; }; 
        struct { Exp *exp_SUB1, *exp_SUB2; }; 
    };
};

int avalia(Exp *exp);
Exp _avalia(Exp *exp);

int main (void){

    Exp exp1;
    exp1.tipo = Num;
    exp1.Num = 3;

    Exp exp2;
    exp2.tipo = Num;
    exp2.Num = 3;

    Exp exp11;
    exp11.tipo = Add;
    exp11.exp_ADD1 = &exp1;
    exp11.exp_ADD2 = &exp2;

    Exp exp3;
    exp3.tipo = Num;
    exp3.Num = 4;

    Exp exp4;
    exp4.tipo = Num;
    exp4.Num = 2;

    Exp exp22;
    exp22.tipo = Add;
    exp22.exp_ADD1 = &exp3;
    exp22.exp_ADD2 = &exp4;

    Exp exp0;
    exp0.tipo = Sub;
    exp0.exp_SUB1 = &exp11;
    exp0.exp_SUB2 = &exp22;

    int resultado = avalia(&exp0);
    printf("%d\n", resultado);

    Exp minima = _avalia(&exp0);
    printf("%d\n", minima.Num);

    
    return 0;
}

int avalia(Exp *exp) {

    switch (exp->tipo){

        case Num:
            return exp->Num;
            break;

        case Add:
            return avalia(exp->exp_ADD1) + avalia(exp->exp_ADD2);
            break;

        case Sub:
            return avalia(exp->exp_SUB1) - avalia(exp->exp_SUB2);
            break;

    }

}

Exp _avalia(Exp *exp) {
    int a, b;

    if(exp->tipo == Num){
        Exp novo;
        novo.tipo = Num;
        novo.Num = exp->Num;
        return novo;
    }

    else if (exp->tipo == Add && (exp->exp_ADD1)->tipo == Num && (exp->exp_ADD2)->tipo == Num){
        a = (exp->exp_ADD1)->Num;
        b = (exp->exp_ADD2)->Num;
        Exp novo;
        novo.tipo = Num;
        novo.Num = a + b;
        return novo;
    }

    else if (exp->tipo == Sub && (exp->exp_SUB1)->tipo == Num && (exp->exp_SUB2)->tipo == Num){
        a = (exp->exp_SUB1)->Num;
        b = (exp->exp_SUB2)->Num;
        Exp novo;
        novo.tipo = Num;
        novo.Num = a - b;
        return novo;
    }

    else if (exp->tipo == Add ){
        Exp exp1 = _avalia((exp->exp_ADD1));
        Exp exp2 = _avalia((exp->exp_ADD2));
        Exp expFinal;
        expFinal.tipo = Add;
        expFinal.exp_ADD1 = &exp1;
        expFinal.exp_ADD2 = &exp2;
        return _avalia(&expFinal);
    }

    else{
        Exp exp1 = _avalia((exp->exp_SUB1));
        Exp exp2 = _avalia((exp->exp_SUB2));
        Exp expFinal;
        expFinal.tipo = Sub;
        expFinal.exp_SUB1 = &exp1;
        expFinal.exp_SUB2 = &exp2;
        return _avalia(&expFinal);
    }

}