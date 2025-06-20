# Data Structures and Algorithms in C++

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Use Cases](#use-cases)
  - [Containers](#containers)
  - [Iterators](#iterators)
  - [Algorithms](#algorithms)
  - [Lambda Functions](#lambda-functions)
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
* `set` vs `unordered_set`
    * `O(log n)` vs `O(1)`
    * but can use mutable elements as keys (e.g. `vector`)

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
* advance iterator
```cpp
auto it = v.cbegin();
std::advance(it, rand() % v.size());
```

### Tuples

* declare
```cpp
std::tuple<std::string, int> mine;
auto t = std::make_tuple("abc", 5);
```
* get: `std::get<0>(mine);`

### Algorithms

* `accumulate`: sum up range
```cpp
int sum = std::accumulate(numbers.begin(), numbers.end(), 0);
```
* `sort`: sort ascending in-place?
```cpp
// Sort the array in descending order cause of rbegin(), rend()
std::sort(numbers.rbegin(), numbers.rend());

// descending using greater
std::sort(numbers.begin(), numbers.end(), std::greater<int>());

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
* `map` has `lower_bound` & `uppder_bound` member functions
```cpp
std::map<int, int> timestamps;
// first key >= value
auto it = timestamps.lower_bound(300);
```
* `rotate`: shift left
```cpp
std::rotate(v.begin(), v.begin() + head, v.end());
```
* `max_element`
    * max element in iterable
    ```cpp
    *std::max_element(v.begin(), v.end());
    ```
    * map
    ```cpp
        std::map<std::string, size_t> counts;
        using pair_type = decltype(counts)::value_type;

        auto ans = *std::max_element(
            counts.begin(), counts.end(),
            [ ](const pair_type& p1, const pair_type& p2) {
                return p1.second < p2.second;
            }
        );
    ```
* `max`: max b/w 2 numbers
```cpp
std::max(5, 2);
```
* find longest string
```cpp
auto longest = [](const string_view s1, const string_view s2) {
    return s1.size() < s2.size();
};

std::string ans(std::max({"int", "double", "short"}, longest));
```
* find index of max element
```cpp
std::distance(nums.begin(), std::max_element(nums.begin(), nums.end()));
```
* `std::swap(var1, var2)`: swap 2 vars

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

## Vector

* `()` vs `{}`
```cpp
// vector of size 500 full of 0s
std::vector<int> v1(500);
// slower
std::vector<int> v2;
v2.reserve(500);

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
* vector of vectors
```cpp
std::vector<std::vector<int>> v(rows, std::vector<int>(cols));
```
* `reserve` vs `resize`
    * `resize`
        - same as giving size to ctor
        - can specify default values (like with ctor): `v.resize(50, 33)`
        - affects only `size`
        - can use `operator[]`
        - push_back inserts elements after `size`
    * `reserve`
        - only allocates mem
        - leaves uninit.
        - affects only `capacity`
        - use only if reasonably precise estimate on total elements
* copy from another iterable container (e.g. `map`, `set`) to `vector`
```cpp
std::copy(seen.begin(), seen.end(), std::back_inserter(v));
```
* copy from heap to `vector`
```cpp
std::vector<int> ans;
std::priority_queue<int, std::vector<int>, std::greater<int>> minHeap;

while (!minHeap.empty()) {
    ans.push_back(minHeap.top());
    minHeap.pop();
}
```
* create `set` from `vector`
```cpp
std::vector<int> v{1,2,2,4,5,5};
std::set<int> s(v.begin(), v.end());
```
* examples
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

* container adapter
* default container: `deque`
```cpp
template<
    class T,
    class Container = std::deque<T>
> class stack;
```
* examples
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

* container adapter
* default container: `deque`
```cpp
template<
    class T,
    class Container = std::deque<T>
> class queue;
```
* examples
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

* container adapter
* default container: `vector`
```cpp
template<
    class T,
    class Container = std::vector<T>,
    class Compare = std::less<typename Container::value_type>
> class priority_queue;
```
* `std::priority_queue<int>`: max heap
* `std::priority_queue<int, std::vector<int>, std::less<int>>`: max heap
* `std::priority_queue<int, std::vector<int>, std::greater<int>>`: min heap
* min heap of pairs
```cpp
using pi = std::pair<int, int>;
std::priority_queue<pi, std::vector<pi>, std::greater<pi>> minHeap;
```
* examples
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

* init
```cpp
map<char, char> dict = {{'}','{'},
                        {')','('},
                        {']','['}};
```
* examples
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
