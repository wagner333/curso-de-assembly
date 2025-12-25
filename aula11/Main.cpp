#include <iostream>

using namespace std;

//
extern "C" {
    int teste1(int valor1, int valor2);
    int teste2(int valor1);
}


int main()
{
    // cout << "Do teste1 em C foi retornado: " << testeA(30, 20) << endl;
    cout << "Do Teste1 em Asm foi retornado: " << teste1(15, 16) << endl;
    // cout << "Do teste2 em C foi retornado: " << testeB(3) << endl;
    cout << "Do Teste2 em Asm foi retornado: " << teste2(2) << endl;
}

int teste1(int valor1, int valor2)
{
    if (valor1 > valor2)
    {
        return valor1;
    }
    else
    {
        return valor2;
    }
}

int teste2(int valor1)
{
    int ret = 0;
    switch (valor1)
    {
    case 1:
        ret = 5;
        break;
    case 2:
        ret = 6;
        break;
    case 3:
        ret = 7;
        break;
    }
    return ret;
}
