#include <iostream>
#include <list>
#include <algorithm>

using namespace std;

int square(int i) {
  return i * i;
}

int main() {
  list<int> l;
  for (int i = 0; i < 10; i++) {
    l.push_back(i);
  }

  list<int> t;
  t.resize(l.size());
  transform(l.begin(), l.end(), t.begin(), square);

  for (list<int>::iterator it = t.begin(); it != t.end(); ++it) {
    cout << " " << *it;
  }

  return 0;
}
