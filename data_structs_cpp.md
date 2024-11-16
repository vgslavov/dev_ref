# Data Structures in C++

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Use Cases](#use-cases)
  - [Containers](#containers)
  - [Iterators](#iterators)
  - [Algorithms](#algorithms)
  - [Lambda Functions](#lambda-functions)
  - [Strings](#strings)
  - [Data Types](#data-types)
- [Vector](#vector)
- [Bit Vector](#bit-vector)
- [Linked List](#linked-list)
- [Stack](#stack)
- [Queue](#queue)
- [Tree](#tree)
  - [Binary](#binary)
  - [BST](#bst)
  - [Trie](#trie)
- [Heap](#heap)
- [Hash Map](#hash-map)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Use Cases

Source: [C++ STL Essentials for Leetcode](https://medium.com/@himanshusingh2719/c-stl-essentials-for-leetcode-2b9d97307feb)

### Containers

* `stack`
    * storing elements in LIFO fashion
    * DFS
* `queue`
    * storing elements in FIFO fashion
    * BFS
* `deque`
    * double-ended queue
    * storing/deleting elements from both ends of vector in `O(1)` time
    * sliding window scenarios
    * supports `operator[]`!
    * use instead of `vector` if you need to `push_front`/`pop_front`
* `priority_queue`
    * max/min heap heap functionality
    * topological sort
* `unordered_map`
    * hash table
    * faster storing/retrieval of data based on some *key* in `O(1)` time
    * performance can degrade to `O(n)`
    * only primitive dataypes & string work as key
    * use when
        * hashing of key is not expensive (primitives)
        * `n` is not large
        * order is not important
* `map`
    * binary search tree
    * faster storing/retrieval of data based on some *object/pair key*
      in `O(log n)` time
    * order of elements matter
    * use when
        * need to iterate over keys
        * `n` is large
* `list`
    * doubly-linked list for LRU-like caches
    * doesn't support `operator[]`
    * use with `unordered_map` of key to List iterators
    * efficient front/back access
    * efficient erase if you have saved iterator

### Iterators

* `begin()`/`end()`: first element & one *past* last element
* `rbegin()`/`rend()`: reverse iterator to last element & one *before* first
    element
* `*it`: iterator value
* `++`/`--`: increment/decrement iterator to move fwd/back
* `+`/`-`: move by `n` positions
* `==`/`!=`/etc: compare
* convert iterator to index
```cpp
std::distance(v.begin(), it)
// or
it - v.begin()
```

### Algorithms

* `accumulate`: sum up range
```cpp
int sum = std::accumulate(numbers.begin(), numbers.end(), 0);
```
* `sort`: sort ascending in-place?
```cpp
// Sort the array in descending order cause of rbegin(), rend()
std::sort(numbers.rbegin(), numbers.rend());

// providing a custom comparator function
sort(temp.begin(), temp.end(),[](const pi &a, const pi &b){
    if (a.second == b.second) return a.first > b.first;
    return a.second < b.second;
});
```
* `reverse`: reverse container
```cpp
std::reverse(numbers.begin(), numbers.end());
```
* `binary_search`: check *if* value exists in *sorted* container
```cpp
bool found = std::binary_search(numbers.begin(), numbers.end(), target);
```
* `lower_bound`: returns an iterator to the first element not less than the
  specified value.
```cpp
int lower = *std::lower_bound(numbers.begin(), numbers.end(), 10);
```
* `upper_bound`: returns an iterator to the first element that is greater than
  the specified value.
* `rotate`: shift left
```cpp
std::rotate(v.begin(), v.begin() + head, v.end());
```
* `max_element`: max element in iterable
```cpp
*std::max_element(v.begin(), v.end());
```

### Lambda Functions

* syntax
```cpp
[capture_clause](parameter_list) -> return_type {
    // Lambda body - lambda with optional return statement
}
```
* simple example
```cpp
auto square = [&factor](int x) -> int {
    return x * x;
};
```
* `capture_clause`
    * what external variables from scope the lambda can access
    * `[]`: empty capture clause, the lambda captures nothing
    * `[var1, var2]`: capture `var1` and `var2` by value, making copies
    * `[&var1, &var2]`: capture `var1` and `var2` by reference
    * `[=]`: capture all external variables by value
    * `[&]`: capture all external variables by reference
    * `[=, &var1]`: capture all variables by value, except `var1` is captured by
      reference
* `parameter_list`
    * parameters of the lambda function
    * similar to regular function parameters
    * data types and names of the parameters are specified
    * or left empty in case of no parameters
* `-> return_type` [optional]
    * the return type of the lambda function
    * if the return type can be deduced by the compiler, can be omitted
* comparator `functor` example
```cpp
// Functor with 'operator' overload
struct CustomComparator {
    bool operator()(const pair<int, int>& a, const pair<int, int>& b) {
        return a.first > b.first;
    }
};

priority_queue<pair<int, int>, vector<pair<int, int>>, CustomComparator> pq;
```

### Strings

* `substr`: extract substring
* `find`: find position of substring in a string
* `replace`: replace substring
* `stoi`: string to number conversion
* `to_string`: number to string conversion
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

### Data Types

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

## Vector

* `()` vs `{}`
```cpp
// vector of size 5 full of 0s
std::vector<int> v1(5);

// vector of size 5 full of 20s
std::vector<int> v2(5, 20);

// vector of size 2
std::vector<int> v3{5, 20};
```
* random access, locality of reference
```cpp
int len = 5;
int def = 0;
vector<int> V(len, def);
vector<int> W(len, 200);
```
* reserve() vs resize()
    * resize
        - same as giving size to ctor
        - can specify default values (like with ctor): V.resize(50, 33);
        - affects only size()
        - can use operator[]
        - push_back inserts elements after size()
    * reserve
        - only allocates mem
        - leaves uninit.
        - affects only capacity()
        - use only if reasonably precise estimate on total elements
```cpp
// allocate memory
// have to deallocate memory
// speed: 1
int *bigarray = new int[N];
bigarray[k] = k;
delete [] bigarray;

// STL
// higher cost: all N are init to 0 (cost only with ints?)
// speed: 2
vector<int> bigarray(N);
bigarray[k] = k;

// pure STL
// speed: 4
vector<int> bigarray;
bigarray.push_back(k);

// use reserve
// speed: 3
vector<int> bigarray;
bigarray.reserve(N);
bigarray.push_back(k);

// cheat (reserve only allocates, size doesn’t change, shouldn’t use operator[]!)
vector<int> bigarray;
bigarray.reserve(N);
bigarray[k] = k;

V.swap(W);      // O(1)!
V.push_back(5); // O(1): amortized
V.emplace_back(5);  // O(1): no new copy
V.at(0);        // O(1)
V[0];           // O(1)
V.size();
V.begin();
V.end();
V.resize(len+10);
```

## Bit Vector

```cpp
// uses less space, each element truly is 1-bit sized (compared to char (8-bit) bool vectors)
bitset<len> bit_vec;

bit_vec.test(5) == 0;
bit_vec.set(((1 << 16) - 1) & x);   // get the lower 16 bits of x

// string
string s;

// array
array<int> A(len, def);
array<int, len> B;
int A[len];

A.size();
A.front();
A.back();
```

## Linked List

```cpp
// STL: implemented as doubly-linked list
list<int> L;

// user-defined
typedef struct Node {
    int data;
    struct Node *next;
    // if double linked list
    struct Node *prev;
} Node;

L.push_front();
L.push_back();

L.pop_front();
L.pop_back();

L.erase();
L.insert();

L.size();
L.empty():
```

## Stack

```cpp
// STL: implemented as array (deque)
stack<int> S;

// user-defined: as linked-list
typedef struct Stack {
    int data;
    struct Struct *next;
} Stack;

S.top();    // O(1)
S.push(5);  // O(1): amortized if implemented as array
S.emplace(5);   // O(1): no new copy
S.pop();    // O(1): amortized if implemented as array
```

## Queue

```cpp
queue<int> Q;

Q.emplace();    // enqueue
Q.push();   // enqueue
Q.pop();    // dequeue

Q.front();
Q.back();
Q.size();

// double-ended queue
deque<int> DQ;
```

## Tree

### Binary

```cpp
// user-defined
typedef struct BinaryTree {
    int data;
    struct BinaryTree *left;
    struct BinaryTree *right;
    // not always available
    struct BinaryTree *parent;
} BinaryTree;
```
* nodes: 2^(h+1) -1
* leaves: 2^h
* height: floor(lg n)

### BST

```cpp
map<int, int> M;
set<int> MS;
```

### Trie

* a.k.a. prefix tree
* implemented using a hash table

## Heap

```cpp
// priority queue
// min-heap: smallest is last in array?
struct Compare {
    bool operator() (const pair<int, int>& lhs, const pair<int, int>& rhs) const
    {
        return lhs.first > rhs.first;
    }
};
// simple data types
priority_queue<int, vector<int>, greater<int> > min_heap;

// max-heap: largest is last in array?
// priority_queue is max-heap by default (but overload Compare for pairs!)
struct Compare {
    bool operator() (const pair<int, int> &lsh, const pair<int, int> &rhs) const
    {
        lhs.first < rhs.first;
    }
};

// simple data types (no need for Compare)
priority_queue<int, vector<int> > max_heap;
// equivalent to
priority_queue<int , vector<int>, less<int> > max_heap2;

max_heap.emplace();     // O(log n): no new copy
max_heap.push();        // O(log n)
max_heap.pop();     // O(log n)

max_heap.top();     // O(1)
```

## Hash Map

```cpp
unordered_map<string, int> HM;
unordered_set<int> HS;

HS.emplace(5);
HS.insert(5);
HM[‘abc’] = 10;
HM[‘abc’];

HS.find(5);
HS.count(5);
```
