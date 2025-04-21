# Idioms C++

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Numbers](#numbers)
- [Strings](#strings)
- [Data Types](#data-types)
- [Classes](#classes)
- [Loops](#loops)
- [C++11](#c11)
- [C++03 vs C++11](#c03-vs-c11)
- [Pointers to Pointers](#pointers-to-pointers)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Numbers

* `std::numeric_limits<int>::min()`: min infinity
* `std::stoi("55")`: string to int, base is auto-detected (`try`/`catch`)
* `std::stoi("1100", nullptr, 2)`: binary string to int (`try`/`catch`)
* `std::stoi("0ff", nullptr, 16)`: hex string to int (`try`/`catch`)
* check if whole string got converted
```cpp
int str2int(const std::string& s) {
    try {
        size_t pos;
        int num = std::stoi(s, &pos, 10);
        if (pos < s.size()) {
            std::cout << "invalid input" << std::endl;
            return -1;
        }

        return num;
    } catch (std::invalid_argument const& ex) {
        std::cout << "invalid_argument: " << ex.what()
                << std::endl;
        return -1;
    } catch (std::out_of_range const& ex) {
        std::cout << "out_of range: " << ex.what()
                << std::endl;
        return -1;
    }

    return -1;
}

std::string s("1e");
int i = str2int(s);   // -1
```
* `std::iota(std::begin(v), std::end(v), 0)`: fill vector with increasing numbers

## Strings

* `std::string(5, "c")`: repeat "c" 5 times
* `std::to_string(5)`: int to string
* `std::bitset<8>(x).to_string()`: int to binary string
* `substr`: extract substring
    * `s.substr(i, s.size())`: from `i` to end (ala Python slicing)
* `find`: find position of substring in a string
* `replace`: replace substring
* splitting: use `istringstream`
```cpp
std::string date("2020-03-20");
std::string delimiter("-");
std::istringstream ss(date); // Creating an input stream
std::string token;
std::vector<std::string> tokens;

while (std::getline(ss, token, delimiter)) {
    tokens.push_back(token);
}
```
* splitting: use `substr` + `find`, like Python's `split()`
```cpp
std::string date = "1970-10-1";
std::string delimiter("-");
int token = std::stoi(date.substr(0, date.find(delimiter)));
date.erase(0, date.find(delimiter) + delimiter.length());
```
* `find_first_not_of`: remove prefix
```cpp
ans.erase(0, std::find_first_not_of("0"));
```
* trim space from left in place
```
s.erase(s.begin(), std::find_if(s.begin(), s.end(),
    [](unsigned char) { return !std::isspace(); }));
```
* string comparisons
```cpp
str1.substr(0, 1) == str2
str1.compare(str2);
```
* iterable to string
```cpp
std::vector<std::string> v;
std::string s(v.begin(), v.end());
```
* `isspace(s)`
* `isalnum(s)`
* character constant: `'.'`vs string literal: `"."`
```cpp
char c = '.';
if (c == '.') {}    // right
if (c == ".") {}    // wrong
```
* character in a string is a `char`, not a `string`
```cpp
std::string s("abc");
// s[2] is a char
```

## Data Types

* chars: 1 byte
    * `signed char`
    * `unsigned char`
* shorts: 2 bytes
    * `short int`
    * `unsigned short int`
* ints: 4 bytes
    * `unsigned int`
    * `int`
    * `long int`
    * `unsigned long int`
* longs: 8 bytes
    * `long long int`
    * `unsigned long long int`
* `float`: 4 bytes
* `double`: 8 bytes
* `long double`: 12 bytes
* `typeid(a).name()`: print type of `a`

## Classes

## Loops

```cpp
// ascending loop
for (size_t i = 0; i != len; ++i) {}

// descending loop
for (size_t i = len; i != 0; ) { --i; }

// erase an item from a list
for (auto i = list.begin(); i != list.end;)
{
    if (cond)
        i = list.erase(i);
    else
        ++i;
}
```

## C++11

```cpp
// lamda expressions
transform(l.begin(), l.end(), t.begin(), [](int i){ return i * i;});

// type inference (auto)
// range-based loops
// list initializers
vector<int> x = {1,2,3,4};
for(auto i : x)
    cout<< i <<endl;

// no hassle initialization of most? containers
const map<string,int> m = {{"Joe",2},{"Jack",3}};

// moving w/o copying
// (no change in code, just new compiler)
vector<vector<int> > V;
for(int k = 0; k < 100000; ++k) {
    vector<int> x(1000);
    V.push_back(x);
}


// constexpr
constexpr int gcd(int x, int y) {
    return (x % y) == 0 ? y :  gcd(y,x % y);
}
// gcd() will never get called at run-time (all at compile-time)
for(int k = 0; k < 100000; ++k) {
    vector<int> x(gcd(1000,100000));
    V.push_back(x);
}
```

## C++03 vs C++11

* C++03
```cpp
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
```
* C++11
```cpp
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
```

## Pointers to Pointers


```cpp
// an array name decays into a ptr to its 1st el
// i.e. array name is ptr to ptr

// case 1: array of ptrs

Shape *picture[MAX];
// same as
Shape **pic1 = picture;

// case 2: change value of a ptr passed to a func

// C
void scanTo(const char **p);

const char *cp;
scanTo(&cp);

// C++
void scanTo(const char *&p);

const char *cp;
scanTo(cp);

// conversions which apply to ptrs DO NOT apply to ptrs to ptrs

// a ptr to a derived class can be converted to a ptr to the base class
Circle *c = new Circle;
Shape *s = c;   // fine, Circle is-a Shape, it's also a ptr to a Shape

// a ptr to a ptr to a Circle is not a ptr to a ptr to a Shape
Circle **c = &c;
Shape **s = cc; // error!

char *s1 = 0;
// can convert a ptr to non-const to a ptr to const
const char *s2 = s1;    // OK
char *a[MAX];           // a.k.a. char **
// cannot convert a ptr to a ptr to non-const to a ptr to ptr to const
const char **ps = a;    // error!
```
