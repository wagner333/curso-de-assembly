#include <iostream>

using namespace std;

extern "C" int Question(int a);
int main(){
    
    if(Question(28) == 1){
        cout << "Numero par" << endl;
    } else {
        cout << "Numero impar" << endl;
    }
    return 0;
}