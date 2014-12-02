#include <iostream>
#include <list>
#include <algorithm>

using namespace std;

int main() {
  // list initializers
  list<int> l = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

  list<int> t;
  t.resize(l.size());
  // lambda expressions
  transform(l.begin(), l.end(), t.begin(), 
        [](int i){ return i * i;});

  // range-based loops,
  // type inference
  for (auto e : t) {
    cout << " " << e;
  }

  return 0;
}
