# Python to C++

## Data Structures

|Python|C++|methods.py|methods.cpp|
|------|---|----|-------|
|`list`|`vector`|`append`,`pop`|`push_back`,`pop_back`|
||`list`||`push_back`, `pop_back`, `push_front`, `pop_front`, `insert`, `erase`|
|`collections.deque`|`deque`|`append`, `pop`, `appendleft`, `popleft`|`push_back`, `pop_back`, `push_front`, `pop_front`|
|`sorted(set())`|`set`|`add`, `del`|`insert`, `erase`|
|`sorted(d.keys())`|`map`|`add`, `del`|`insert`, `erase`|
|`set`|`unordered_set`|`add`, `del`|`insert`, `erase`|
|`dict`/`defaultdict`|`unordered_map`|`add`, `del`|`insert`, `erase`|
|`list`|`stack`|`append`, `pop`|`push`, `pop`|
|`collections.deque`|`queue`|`append`, `pop`|`push`, `pop`|
|`heapq`|`priority_queue`|`heapq.heappush`, `heapq.heappop`|`push`, `pop`|
|`tuple`|`tuple`|