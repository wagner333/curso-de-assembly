#include <iostream>

using namespace std;

extern "C" long Fibonacci(long a);

int main(){
  cout << "o 8 elemeente de fibonacci é:" << Fibonacci(0) << endl;
  return 0;
}


