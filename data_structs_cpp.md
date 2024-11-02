# Data Structures in C++

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

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

## Vector

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
