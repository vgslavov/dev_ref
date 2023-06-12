# Data Structures in Python

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Sources](#sources)
- [`list`: `[]`](#list-)
  - [List](#list)
  - [Stack](#stack)
  - [Comprehensions](#comprehensions)
- [`tuple`: `()`](#tuple-)
- [`deque`](#deque)
- [`heapq` algorithm](#heapq-algorithm)
  - [Create](#create)
  - [Sort](#sort)
  - [Get N largest/smallest](#get-n-largestsmallest)
  - [Use as a priority queue](#use-as-a-priority-queue)
- [`set`: `{}`](#set-)
- [`dict`: `{:}`](#dict-)
  - [`defaultdict`](#defaultdict)
  - [`OrderedDict`](#ordereddict)
  - [`Counter`](#counter)
  - [Calculations](#calculations)
- [`itertools`](#itertools)
- [Looping](#looping)
- [Conditions & Comparisons](#conditions--comparisons)
- [Sorting](#sorting)
- [Searching](#searching)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Sources

* [Python Data Structures](https://docs.python.org/3/tutorial/datastructures.html)
* [Sorting HOW TO](https://docs.python.org/3/howto/sorting.html)
* Python Cookbook (by David Beazley)

## `list`: `[]`

* *homogeneous* sequence of elements
* mutable
* ordered
* can have duplicates
* accessed by iterating

### List

* `del`
    * `del a[0]`: delete 0th index
    * `del a[2:4]`: delete slice of [2 to 4)
    * `del a[:]`: delete all elements (same as `clear`)
    * `del a`: delete variable
* `sort`: sort *in place* (cmp to `sorted()`: creates new)
* `reverse`: reverse *in place*
* `copy`: shallow copy
* deep copy
    * `b = list(a)`
    * `c = a[:]`

### Stack

* LIFO
```
stack = []
# push
stack.append(6)
stack.append(8)
# pop
stack.pop()
```

### Comprehensions

> A list comprehension consists of brackets containing an expression followed by
> a for clause, then zero or more for or if clauses.
- Python Docs

* simple
```
squares = [x**2 for x in range(10)]
# same as
squares = list(map(lambda x: x**2, range(10)))
```
* nested
```
matrix = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
]

[[row[i] for row in matrix] for i in range(4)]
# same as
list(zip(*matrix))
```

## `tuple`: `()`

* *heterogeneous* sequence of elements
* immutable
* ordered
* can have duplicates
* can contain mutable objects (e.g. lists): `([1, 2, 3], [3, 2, 1])`
* can be nested
* accessed by unpacking or indexing
* empty tuple: `empty = ()`
* singleton: `singleton = 'hello',`
* tuple packing: `t = 12345, 54321, 'hello'`
* sequence unpacking: `x, y, z = t`

## `deque`

* queue (FIFO)
```
import collections

q = deque(maxlen=3)
# add to end of queue
q.append(5)                 # O(1)
q.appendleft(3)             # O(1)
# remove from end of queue
q.pop()                     # O(1)
# remove from beginning of queue
q.popleft()                 # O(1)
```

## `heapq` algorithm

* heap queue: a.k.a. priority queue
* min-heap: `heap[0]` is smallest
* parent (is smaller): `heap[k] > heap[math.floor((k-1)/2)]`
* left (is larger): `heap[k] <= heap[2*k+1]`
* right (is larger): `heap[k] <= heap[2*k+2]`
* differences from textbook algorithms
    * 0-based indexing
    * pop returns smallest (i.e. min heap)
* a regular Python list
    * `heap[0]` is smallest item
    * `heap.sort()` maintains heap invariant
    * start with empty `[]`
    * or `heapq.heapify(l)` existing list in O(N) time
* every sorted list satisfies the heap property!
* `heapq.merge`: O(N log N), iterate + `heapify`?

### Create

```
h = list(nums)           # deep copy of list
heapq.heapify(h)         # O(N): create heap from list
heapq.heappop(h)         # O(log N): return smallest element & remove it
heapq.heappush(h, 1)     # O(log N): add element to heap
heapq.heappushpop(h, 1)  # push then pop smallest: more efficient
heapq.heapreplace(h, 1)  # pop smallest then push: more efficient
```

### Sort

```
import heapq

def heapsort(iterable):
    'Equivalent to sorted(iterable)'
    h = []
    # generic, any iterable
    for value in iterable:
        heapq.heappush(h, value)
    # list only
    #heapq.heapify(iterable)

    return [heapq.heappop(h) for i in range(len(h))]

heapsort([1, 3, 5, 7, 9, 2, 4, 6, 8, 0])
# [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### Get N largest/smallest

```
# O(N + log(m)): m is top m
heapq.nlargest(3, nums)
# same as
sorted(nums, reverse=True)[:3]
# same elements, opposite order
sorted(nums)[-3:]

# O(N + log(m)): m is top m
heapq.nsmallest(3, nums)
# same as
sorted(nums)[:3]
# same elements, opposite order
sorted(nums, reverse=True)[-3:]

if N == 1:
    max(nums)
    min(nums)
elif N ~ len(nums):
    # N smallest
    sorted(nums)[:N]
    # N largest
    sorted(nums, reverse=True)[:N]
```

### Use as a priority queue

```
h = []
heappush(h, (5, 'write code'))
heappush(h, (7, 'release product'))
heappush(h, (1, 'write spec'))
heappush(h, (3, 'create tests'))
heappop(h) # (1, 'write spec')

# To make stable and break ties
# (return tasks in order pushed if same priority),
# maintain an index (order of pushing) and add to tuple:
# (priority, index, task). Negate priority to reverse order
# (to get tasks with highest priority).

index = 0
heappush(h, (-5, index, 'write code'))
index += 1
```

## `set`: `{}`

* an *unordered* collection of *heterogeneous* unique elements
* mutable
* uses
    * membership testing
    * eliminating duplicates
* operations
    * union: `|`
    * intersection: `&`
    * difference: `-`
    * symmetric difference (a.k.a. XOR): `^`
* empty set: `set()` (not `{}`)
* set comprehension
```
a = {x for x in 'abracadabra' if x not in 'abc'}
```

## `dict`: `{:}`

* heterogeneous sequence of elements
* mutable
* ordered >= v3.7, unordered prior
* like C++ `map` & `unordered_map`
* can not have duplicates
* indexed by keys
* keys can be strings or numbers
* keys have to be immutable only (e.g. tuples but not lists)
* keys are unique
* *key: value* pairs
* empty dictionary: `{}`
* `dict()`
    * build dictionary (same as `{}`)
    * use keys: `dict(id=1234, ext=212)`
* list of `dict` keys (in insert order): `list(d)`
* sorted list of `dict` keys: `sorted(d)`
* check membership: `'hello' in d`
* `del d['hello']`: delete key
* dict comprehension
```
{x: x**2 for x in (2, 4, 6)}
```

### `defaultdict`

```
d = {
    'a' : [1, 2, 3],
    'b' : [4, 5]
}

e = {
    'a' : {1, 2, 3},
    'b' : {4, 5}
}

from collections import defaultdict
d = defaultdict(list)       # makes it easier to init default values
d['a'].append(1)            # so you can just add items
d['a'].append(2)            # (w/o checking if list/set exists already)
d['b'].append(4)
...
e = defaultdict(set)
e['a'].add(1)
e['a'].add(2)
e['b'].add(4)
# ...

d = defaultdict(list)
for key, value in pairs:
    d[key].append(value)
```

### `OrderedDict`

* like C++ `map`
* preserves original insertion order (useful for serializing/encoding to JSON)
* twice the size of a regular dict (implemented as a doubly-linked list)
```
from collections import OrderedDict

d = OrderedDict()
d['foo'] = 1
d['bar'] = 2
d['spam'] = 3
d['grok'] = 4
# Outputs "foo 1", "bar 2", "spam 3", "grok 4"
for key in d:
    print(key, d[key])

import json
json.dumps(d)  # '{"foo": 1, "bar": 2, "spam": 3, "grok": 4}'
```

### `Counter`

* count most frequently occurring items in a *sequence*
```
words = [
       'look', 'into', 'my', 'eyes', 'look', 'into', 'my', 'eyes',
       'the', 'eyes', 'the', 'eyes', 'the', 'eyes', 'not', 'around', 'the'
]
more_words = [ 'eyes', 'nose' ]

from collections import Counter

word_counts = Counter(words)
word_counts.update(more_words)
top_three = word_counts.most_common(3)
b = Counter(other_words)
c = word_counts + b         # combine counts
d = word_counts - b         # subtract counts
```

### Calculations

* invert dict into (value, key) pairs using zip()
```
prices = {
   'ACME': 45.23,
   'AAPL': 612.78,
   'IBM': 205.55,
   'HPQ': 37.20,
   'FB': 10.75
}

min_price = min(zip(prices.values(), prices.keys()))
# min_price is (10.75, 'FB')

prices_sorted = sorted(zip(prices.values(), prices.keys()))
# prices_sorted is [(10.75, 'FB'), (37.2, 'HPQ'),
#                   (45.23, 'ACME'), (205.55, 'IBM'),
#                   (612.78, 'AAPL')]

# 3.4 set operations

# intersection: keys in common
a.keys() & b.keys()

# complement: keys in a but not in b (a \ b)
a.keys() - b.keys()

# common key,value pairs
a.items() & b.items()

# make a new dictionary with certain keys removed
c = {key:a[key] for key in a.keys() - {'z', 'w'}}
# c is {'x': 1, 'y': 2}
```

## `itertools`

* `groupby`: group records based on field
```
rows = [
        {'address': '5412 N CLARK', 'date': '07/01/2012'},
        {'address': '5148 N CLARK', 'date': '07/04/2012'},
        {'address': '5800 E 58TH', 'date': '07/02/2012'}
]

from operator import itemgetter
from itertools import groupby

# have to sort by field 1st! 
# (groupby only examines consecutive items)
rows.sort(key=itemgetter('date'))

# iterate over grouped by fields
for date, items in groupby(rows, key=itemgetter('date')):
    print(date)
    for i in items:
        print(i)
```
* `compress`

## Looping

* `dict`
```
for k, v in d.items():
    print(k, v)
```
* `list`
```
for i, v in enumerate(l):
    print(i, v)
```
* multiple sequences
```
for q, a in zip(questions, answers):
    print('{0}? {1}'.format(q, a))
```
* reverse loop
```
for i in reversed(range(1, 10, 2)):
    print(i)
```
* sorted loop
```
for i in sorted(l):
    print(i)
```
* sorted & unique loop
```
for f in sorted(set(l)):
    print(f)
```
* don't loop & push/pop over the same sequence
```
# wrong
for e in stack:
    stack.pop()

# right
while len(stack):
    stack.pop()
```

## Conditions & Comparisons

* membership: `in`, `not in`
* identity (same obj): `is`, `is not`
* equality (same value): `==`
* chaining: `a < b == c`
* logical: `and`, `or`
* `A and not B or C` == `(A and (not B)) or C`
* *short-circuit* operators: `A and B and C` (C is not evaluated if B is false)
* *lexicographical* ordering of comparisons: 1st two items are compared & so on
```
(1, 2, 3)              < (1, 2, 4)
[1, 2, 3]              < [1, 2, 4]
'ABC' < 'C' < 'Pascal' < 'Python'
(1, 2, 3, 4)           < (1, 2, 4)
(1, 2)                 < (1, 2, -1)
(1, 2, 3)             == (1.0, 2.0, 3.0)
(1, 2, ('aa', 'ab'))   < (1, 2, ('abc', 'a'), 4)
```

## Sorting

* `sorted()`
    * returns new sorted iterable
    * works for any iterable
* `list.sort()`
    * in-place sort
    * `list` only
    * more efficient than `sorted()`
* `key` functions
```
# by length
sorted(['table', 'fish', 'apartment'], key=len)

# split & make lower case
sorted("This is a test string from Andrew".split(), key=str.lower)

sorted(student_tuples, key=lambda student: student[2])
# same as
from operator import itemgetter, attrgetter
sorted(student_tuples, key=itemgetter(2))

# for user-defined classes, use lambda or attrgetter
sorted(student_objects, key=lambda student: student.age)
# same as (use student.age)
sorted(student_objects, key=attrgetter('age'))

# for dict, use itemgetter
sorted(student_objects, key=itemgetter('age'))

# multi-level sorting
sorted(student_objects, key=attrgetter('grade', 'age'))

# can apply min/max with both item & attr getters
# rows is a dict with uuid key
min(rows, key=itemgetter('uuid'))
# users is an instance of class User with age attribute
max(users, key=attrgetter('age')))
```
* ascending by default, descending using `reverse`
```
sorted(student_tuples, key=itemgetter(2), reverse=True)
# same as
list(reversed(sorted(reversed(data), key=itemgetter(2))))
```
* guaranteed to be stable: preserve order of same key records
* multisort
```
s = sorted(student_objects, key=attrgetter('age'))     # sort on secondary key
sorted(s, key=attrgetter('grade'), reverse=True)       # now sort on primary key, descending

# same as
def multisort(xs, specs):
    for key, reverse in reversed(specs):
        xs.sort(key=attrgetter(key), reverse=reverse)
    return xs

multisort(list(student_objects), (('grade', True), ('age', False)))
```
* Decorate-Sort-Undecorate (DSU)
```
decorated = [(student.grade, i, student) for i, student in enumerate(student_objects)]
decorated.sort()
[student for grade, i, student in decorated]               # undecorate
```
* define `__lt__` in user-defined classes
```
Student.__lt__ = lambda self, other: self.age < other.age
```
* using keys from another dict
```
sorted(students, key=newgrades.__getitem__)
```

## Searching

* `bisect`
```
# binary search: works on ascending sorted order only!
i = bisect.bisect_left(v, k)
if i < len(v) and v[i] == k:
    return True
```
