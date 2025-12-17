# Python to C++

## Data Structures

|Python|C++|Common Methods (Python)|Common Methods (C++)|Notes|
|------|---|---------------------|-------------------|-----|
|`list`|`vector`|`append(x)`, `pop()`, `pop(i)`, `insert(i,x)`, `remove(x)`, `clear()`, `index(x)`, `count(x)`|`push_back(x)`, `pop_back()`, `erase(it)`, `insert(it,x)`, `clear()`, `size()`|Python `list` supports negative indexing and slicing; C++ uses iterators|
|`collections.deque`|`deque`|`append(x)`, `appendleft(x)`, `pop()`, `popleft()`, `extend(iter)`, `extendleft(iter)`, `rotate(n)`|`push_back(x)`, `push_front(x)`, `pop_back()`, `pop_front()`, `insert(it,x)`, `erase(it)`|Both support O(1) operations at both ends|
|`set`|`unordered_set`|`add(x)`, `remove(x)`, `discard(x)`, `clear()`, `union(\|)`, `intersection(&)`, `difference(-)`|`insert(x)`, `erase(x)`, `erase(it)`, `find(x)`, `count(x)`, `clear()`|Python `set` has set operations (`\|`, `&`, `-`, `^`); C++ uses algorithms|
|`set` (sorted iteration)|`set`|`sorted(s)` returns list|Iteration is naturally sorted|C++ `set` maintains sorted order; Python needs explicit `sorted()`|
|`dict`|`unordered_map`|`d[k]`, `d.get(k,default)`, `d.setdefault(k,default)`, `keys()`, `values()`, `items()`, `del d[k]`, `pop(k)`, `clear()`|`operator[]`, `at(k)`, `insert({k,v})`, `erase(k)`, `find(k)`, `count(k)`, `clear()`|Python dict preserves insertion order (3.7+); C++ `unordered_map` doesn't|
|`dict` (sorted by key)|`map`|`sorted(d.keys())` for iteration|Iteration is naturally sorted by key|C++ `map` maintains key-sorted order; Python needs explicit `sorted()`|
|`collections.OrderedDict`|No direct equivalent|`move_to_end(k)`, `popitem(last=True)`, standard dict methods|Use `map` if key-sorted needed, or combine `list`+`unordered_map`|C++ `map` is key-sorted, not insertion-ordered|
|`collections.defaultdict`|No direct equivalent|`d[k]` (auto-creates default), `__missing__`|Use `unordered_map` + manual check, or custom wrapper|C++ requires explicit default value handling|
|`collections.Counter`|`unordered_map<T, int>` or custom|`update(iter)`, `elements()`, `most_common(n)`, `+`, `-`|`operator[]`, `insert()`, `count()`, custom logic|C++ requires manual implementation for counter operations|
|`list` (as stack)|`stack`|`append(x)`, `pop()`, `[-1]` (top)|`push(x)`, `pop()`, `top()`|Python uses `list`; C++ uses adapter over `deque`|
|`collections.deque` (as queue)|`queue`|`append(x)`, `popleft()`, `[0]` (front)|`push(x)`, `pop()`, `front()`, `back()`|Python uses `deque`; C++ uses adapter over `deque`|
|`heapq` (min-heap)|`priority_queue`|`heappush(h,x)`, `heappop(h)`, `heapify(h)`, `heappushpop(h,x)`, `heapreplace(h,x)`, `nlargest(n,iter)`, `nsmallest(n,iter)`|`push(x)`, `pop()`, `top()`|Python `heapq` is min-heap; C++ defaults to max-heap (use `greater<T>` for min-heap)|
|`tuple`|`tuple`|Indexing: `t[i]`, unpacking: `a,b,c = t`, `count(x)`, `index(x)`|`get<i>(t)`, structured bindings: `auto [a,b,c] = t`|Both immutable, fixed-size, heterogeneous|
|`frozenset`|No direct equivalent|`frozenset(s)`, set operations, `issubset()`, `issuperset()`|Use `const set` or custom wrapper|Python has built-in immutable set; C++ requires const wrapper|
|No direct equivalent|`list` (doubly-linked)|N/A|`push_back(x)`, `push_front(x)`, `pop_back()`, `pop_front()`, `insert(it,x)`, `erase(it)`, `splice()`|C++ `list` is doubly-linked; Python uses `deque` for similar use cases|
|No direct equivalent|`forward_list` (singly-linked)|N/A|`push_front(x)`, `pop_front()`, `insert_after(it,x)`, `erase_after(it)`|Singly-linked list; Python doesn't have direct equivalent|
|`queue.Queue` (thread-safe)|No direct STL equivalent|`put(x)`, `get()`, `empty()`, `qsize()`|Use `std::queue` + `std::mutex` for thread safety|Python has built-in thread-safe queue; C++ requires manual synchronization|
|`array.array`|`vector<T>` or `array<T,N>`|`append(x)`, `pop()`, `fromlist()`, `tolist()`|`push_back(x)`, `pop_back()`, `fill(val)`|Python `array` is typed; C++ `vector` is generic container, `array` is fixed-size|
|`str` (immutable)|`std::string` (mutable)|`split()`, `join()`, `find()`, `replace()`, `strip()`, slicing|`substr(pos,len)`, `find()`, `replace()`, `operator+`, `append()`|Python strings are immutable; C++ strings are mutable|
|No direct equivalent|`array<T, N>` (fixed-size)|N/A|`at(i)`, `operator[]`, `fill(val)`, `size()`|Fixed-size, stack-allocated array; Python uses `list` or `array.array`|
|No direct equivalent|`bitset<N>`|N/A|`set(i)`, `reset(i)`, `flip(i)`, `test(i)`, `count()`, bitwise operators|Fixed-size bit array; Python uses `int` with bitwise ops or `bitarray` library|