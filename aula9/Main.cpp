#include <iostream>

using namespace std;

extern "C" int GetValorASM(int a);

int main(){
    cout << "ASM me deu " << GetValorASM(0) << endl;
    return 0;
}