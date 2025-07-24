# Data Structures and Algorithms in Python

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
- [`functools`](#functools)
- [Looping](#looping)
- [Conditions & Comparisons](#conditions--comparisons)
- [Sorting](#sorting)
- [Searching](#searching)
- [Algorithms](#algorithms)

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

* slicing
```py
a[start:stop:step] # start through not past stop, by step
a[slice(start, stop, step)] # using slice obj
a[start:stop]      # items start through stop-1
a[start:]          # items start through the rest of the array
a[:stop]           # items from the beginning through stop-1
a[:]               # a copy of the whole array

a[-1]              # last item in the array
a[-2:]             # last two items in the array
a[:-2]             # everything except the last two items

a[::-1]            # all items in the array, reversed
a[1::-1]           # the first two items, reversed
a[:-3:-1]          # the last two items, reversed
a[-3::-1]          # everything except the last two items, reversed
```
* `del`
    * `del a[0]`: delete 0th index
    * `del a[2:4]`: delete slice of [2 to 4)
    * `del a[:]`: delete all elements (same as `clear`)
    * `del a`: delete variable
* `sort`: sort *in place* (cmp to `sorted()`: creates new)
* `reverse`: reverse *in place* (cmp to `reversed()`: generator)
* shallow copy
    * `b = list(a)`
    * `c = a[:]`
    * `d = a.copy()`
* deep copy
    * `b = copy.deepcopy(a)`
* concat
    * `a += b`
    * `a.extend(b)`
    * `c = [*a, *b]` [Python >= 3.5]
* to string
    * of chars: `''.join(chars)`
    * of nums: `''.join([str(d) for d in digits])`
* unpacking: `[*p, '3']`

### Stack

* LIFO
```py
stack = []
# push
stack.append(6)
stack.append(8)
# pop
stack.pop()
```

### Comprehensions

> A list comprehension consists of brackets containing an expression followed by
> a `for` clause, then zero or more `for` or `if` clauses.
> Python Docs

* can only use `for` (`while` not allowed)
* simple
```py
squares = [x**2 for x in range(10)]
```
* same using `map`
```py
squares = list(map(lambda x: x**2, range(10)))
```
* a predicate
```py
list(x for x in range(10) if is_even(x))
```
* same using `filter`
```py
list(filter(is_even, range(10)))
```
* nested
```py
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
```py
import collections

l = [1, 2, 3]
# make deque out of list
q = deque(l)
# create deque of size n
q = deque(maxlen=3)
# add list to deque
q.extend(l)
# add to end of queue
q.append(5)                 # O(1)
# add to beginning of queue
q.appendleft(3)             # O(1)
# remove from end of queue
q.pop()                     # O(1)
# remove from beginning of queue
q.popleft()                 # O(1)
# reverse queue
q.reverse()
# rotate n steps to right
q.rotate(3)
# rotate n steps to left
q.rotate(-3)
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
* `heapq.merge`
    * complexity: O(n log n)
    * iterate + `heapify`?
    * returns a generator

### Create

```py
h = list(nums)           # deep copy of list
heapq.heapify(h)         # O(N): create min heap from list
heapq._heapify_max(h)    # O(N): create max heap from list
heapq.heappop(h)         # O(log N): return smallest element & remove it
heapq._heappop_max(h)    # O(log N): return largest element & remove it
heapq.heappush(h, 1)     # O(log N): add element to heap
heapq.heappushpop(h, 1)  # push then pop smallest: more efficient
heapq.heapreplace(h, 1)  # pop smallest then push: more efficient
```

### Sort

```py
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

```py
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

```py
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
* can't add non-hashable (e.g. lists): `s.add([1,2]) # error`
* can add tuples: `s.add((1,2))`
* operations
    * union: `|`
    * intersection: `&`
    * difference: `-`
    * symmetric difference (a.k.a. XOR): `^`
* empty set: `set()` (not `{}`)
* set comprehension
```py
a = {x for x in 'abracadabra' if x not in 'abc'}
```

## `dict`: `{:}`

* heterogeneous sequence of elements
* mutable
* ordered >= v3.7, unordered prior
    * order is *insertion* order, not sorted key order
    * to provide *key* order like C++ `map`: `for k in sorted(d.keys())`
    * designed for *mapping* operations
* ~~like C++ `map` & `unordered_map`~~
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
* next/first key: `next(iter(d))`
* sorted list of `dict` keys: `sorted(d)`
* check membership: `'hello' in d`
* `del d['hello']`: delete key
* dict comprehension
```py
# key: number, value: number's square
{x: x**2 for x in (2, 4, 6)}

# key: number, value: index in array
{num: i for i, num in enumerate(nums)}
```

### `defaultdict`

* set default value `defaultdict(int)` or `defaultdict(list)`
* looking up a non-existing key returns a default value: `0` or `[]`

```py
d = {
    'a' : [1, 2, 3],
    'b' : [4, 5]
}

e = {
    'a' : {1, 2, 3},
    'b' : {4, 5}
}

from collections import defaultdict
# create dict with a default value of int (0)
z = defaultdict(int)
z[4] += 1
z[3] += 1
# create dict with a default value of list
d = defaultdict(list)       # makes it easier to init default values
d['a'].append(1)            # so you can just add items
d['a'].append(2)            # (w/o checking if list/set exists already)
d['b'].append(4)
...
# create dict with a default value of set
e = defaultdict(set)
e['a'].add(1)
e['a'].add(2)
e['b'].add(4)
# ...

d = defaultdict(list)
for key, value in pairs:
    d[key].append(value)

# list from defaultdict
l = [k for k,v in d.items() if v > 2]
```

### `OrderedDict`

* ~~like C++ `map`~~
* preserves original *insertion* order (useful for serializing/encoding to JSON)
* twice the size of a regular dict (implemented as a doubly-linked list)
* designed for *reordering* operations
* `move_to_end`
    * move existing key to end of dict
    * `move_to_end(key, last=False)`: move existing to beginning
* `popitem`
    * return & remove key,value pair in *LIFO* order
    * `popitem(last=False)`:  in *FIFO* order
* example
```py
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
```py
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

b['missing']                # count of missing element is 0
```

### Calculations

* invert dict into (value, key) pairs using zip()
```py
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
```py
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
* `chain`: concat iterables
```py
import itertools

j = list(itertools.chain(l1, l2))
```

## `functools`

* `@cache`: use for memoization in DP
* `@lru_cache(maxsize=None)`: same as `@cache`

## Looping

* over `dict` using `items`
```py
for k, v in d.items():
    print(k, v)
```
* over `list` using `enumerate`
```py
for i, v in enumerate(l):
    print(i, v)
```
* over multiple sequences using `zip`: lazy evaluation
```py
for q, a in zip(questions, answers):
    print('{0}? {1}'.format(q, a))
```
* `range(start, stop)`: [start, stop), stop is excluded
* specific `range`: 1 to n-1
```py
for i in range(1, len(nums)):
```
* `range(len(n)-1, -1, -1)`: go backwards with index
* `reversed` loop
```py
for i in reversed(range(len(nums)):
    print(nums[i])
```
* `reversed` loop for reversing string
```py
for c in reversed(s):
    print(s)
```
* `sorted` loop
```py
for i in sorted(l):
    print(i)
```
* `sorted` & unique loop using `set`
```py
for f in sorted(set(l)):
    print(f)
```
* over list of intervals: `[[1,3],[6,0]]`
```py
for start, end in intervals:
```
* don't loop & push/pop over the same sequence
```py
# wrong: list
for e in stack:
    stack.pop()

# right: list
while len(stack):
    stack.pop()

# wrong: list
for i in range(1, len(nums)):
    del nums[i-1]

# right: list
i = 0
while i < len(nums):
    del nums[i-1]
    i += 1

# wrong: dict
for k,v in d.items():
    if k == 2:
        del d[k]

# right: dict
for k in list(d.keys()):
    if k == 2:
        del d[k]
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
```py
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
    * reverse: `sorted(list, reverse=True)`
* `list.sort()`
    * in-place sort
    * `list` only
    * more efficient than `sorted()`
    * reverse: `list.sort(reverse=True)`
* sorting a string: `text = ''.join(sorted(text))`
* ala `cat list | sort | uniq`: `sorted(set(list))`
* sorting a `dict`
```py
# by key
dict(sorted(d.items()))

# by value
dict(sorted(d.items(), key=lambda item: item[1]))

# dict values to string
''.join([d[key] for key in sorted(d.keys())])
```
* `key` functions
```py
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
```
* ascending by default, descending using `reverse`
```py
sorted(student_tuples, key=itemgetter(2), reverse=True)
# same as
list(reversed(sorted(reversed(data), key=itemgetter(2))))
```
* guaranteed to be stable: preserve order of same key records
* multisort
```py
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
```py
decorated = [(student.grade, i, student) for i, student in enumerate(student_objects)]
decorated.sort()
[student for grade, i, student in decorated]               # undecorate
```
* define `__lt__` in user-defined classes
```py
Student.__lt__ = lambda self, other: self.age < other.age
```
* using keys from another dict
```py
sorted(students, key=newgrades.__getitem__)
```
* custom comparator: TODO
* reverse string: `''.join(reversed(s))`

## Searching

* `bisect`
```py
# binary search: works on ascending sorted order only!
i = bisect.bisect_left(v, k)
if i < len(v) and v[i] == k:
    return True
```
* `max`/`min`
```py
# can apply min/max with both item & attr getters
# rows is a dict with uuid key
min(rows, key=itemgetter('uuid'))
# users is an instance of class User with age attribute
max(users, key=attrgetter('age')))

# index of min element
values = [1,2,4,0,99,32]
min(range(len(values)), key=values.__getitem__)   // returns 3

# max length string
max(['abcd','ab','daaded'], key=len)

# key with max dict value
max(counts, key=counts.get)
# max dict value
max(counts.values(), default=0)

# max of 3rd value of an array of arrays
intervals = [[1947, 2000, 5], [2001, 2009, 78]]
max(intervals, key=lambda x: x[2])[2]
```

## Algorithms

* `sum`: add number of non-zero keys in a `dict`
    * `sum(d[k] != 0 for k in d.keys())`
    * `sum(1 for k in d.keys() if d[k])`
* `sum`: add even values in a `dict`
```py
sum(v for v in d.values() if v % 2 == 0)
```
* `math.comb`: calc combinations
* `math.perm`: calc permutations
* `math.factorial`: calc factorial
* `list(set(sorted(list(itertools.permutations("AAB", 2)))))`:
  permutations of "AAB" taken 2 chars at-a-time
