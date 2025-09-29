# Python to C++

## Data Structures

|Python|C++|methods.py|methods.cpp|
|------|---|----|-------|
|`list`|`vector`|`append`,`pop`|`push_back`,`pop_back`|
|`collections.deque`|`deque`|`append`, `pop`, `appendleft`, `popleft`|`push_back`, `pop_back`, `push_front`, `pop_front`|
|`sorted(set())`|`set`|`add`, `del`|`insert`, `erase`|
|`sorted(dict().keys())`|`map`|`add`, `del`|`insert`, `erase`|
|`set`|`unordered_set`|`add`, `del`|`insert`, `erase`|
|`dict`/`defaultdict`|`unordered_map`|`add`, `del`|`insert`, `erase`|
|`list`|`stack`|`append`, `pop`|`push`, `pop`|
|`collections.deque`|`queue`|`append`, `pop`|`push`, `pop`|
|`heapq`|`priority_queue`|`heapq.heappush`, `heapq.heappop`|`push`, `pop`|
|`tuple`|`tuple`|
|`frozenset`|No direct equivalent (`const set` or custom wrapper)|`add`, `del`|`insert`, `erase`|
|No direct equivalent|`list` (doubly linked list), `forward_list` (singly linked list)||`push_back`, `pop_back`, `push_front`, `pop_front`, `insert`, `erase`|
|`dict`/`collections.OrderedDict`|No direct equivalent (`map` is ordered by key, not insertion)|`__setitem__`, `__delitem__`|`insert`, `erase`|
|`collections.Counter`|`unordered_map<T, int>`, `multiset`|`update`, `elements`, `most_common`|`insert`, `count`, `equal_range`|
|`collections.defaultdict`|No direct equivalent (use `unordered_map` with default value or custom wrapper)|`__getitem__`|`operator[]`|
|`queue.Queue`, `LifoQueue`, `PriorityQueue` (thread-safe)|No direct equivalent in STL (use `std::queue`, `std::stack`, `std::priority_queue` + mutex for thread safety)|||
|`array.array`|`vector<T>`, `array<T, N>`|`append`, `pop`|`push_back`, `pop_back`|
|`str` (immutable)|`std::string` (mutable)|||
|No direct equivalent|`array<T, N>` (fixed size, stack-allocated)|||
|No direct equivalent|`bitset`|bit operations|bit operations|