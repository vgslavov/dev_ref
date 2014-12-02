# 1. Deque (double-ended queue)
import collections

>>> q = deque(maxlen=3)
q.append(5)					O(1)
q.appendleft(3)				O(1)
q.pop()						O(1)
q.popleft()					O(1)

# 2. Heapq (heap, priority queue)
import heapq

min-heap (heap[0] is smallest)
parent (is smaller): heap[k] > heap[math.floor((k-1)/2)]
left (is larger): heap[k] <= heap[2*k+1]
right (is larger): heap[k] <= heap[2*k+2]

# 2.1 create

>>> nums = [1, 8, 2, 23, 7, -4, 18, 23, 42, 37, 2]
>>> import heapq
>>> heap = list(nums)			deep copy of list
>>> heapq.heapify(heap)			O(N)
>>> heap
[-4, 2, 1, 23, 7, 2, 18, 23, 42, 37, 8]
>>> heapq.heappop(heap)			O(log N)
-4

# 2.2 sort

>>> def heapsort(iterable):
...    'Equivalent to sorted(iterable)'
...    h = []
...    for value in iterable:
...        heappush(h, value)
...    return [heappop(h) for i in range(len(h))]
...
>>> heapsort([1, 3, 5, 7, 9, 2, 4, 6, 8, 0])
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# 2.3 get N largest/smallest

>>> nums = [1, 8, 2, 23, 7, -4, 18, 23, 42, 37, 2]
print(heapq.nlargest(3, nums)) # Prints [42, 37, 23]
print(heapq.nsmallest(3, nums)) # Prints [-4, 1, 2]

if N == 1:
	max(nums)
	min(nums)
elif N ~ len(nums):
	# N smallest
	sorted(nums)[-N:]
	# N largest
	sorted(nums)[:N]

# 2.4 use as a priority queue

>>> h = []
>>> heappush(h, (5, 'write code'))
>>> heappush(h, (7, 'release product'))
>>> heappush(h, (1, 'write spec'))
>>> heappush(h, (3, 'create tests'))
>>> heappop(h)
(1, 'write spec')

# To make stable and break ties (return tasks in order pushed if same priority), maintain an index (order of pushing) and add to tuple: (priority, index, task). Negate priority to reverse order (to get tasks with highest priority).

>>> index = 0
>>> heappush(h, (-5, index, 'write code'))
>>> index += 1

# 3. Dict

# 3.1 multidict
from collections import defaultdict

d={
'a' : [1, 2, 3],
'b' : [4, 5]
}
e={
'a' : {1, 2, 3},
'b' : {4, 5}
}

>>> from collections import defaultdict
    d = defaultdict(list)		# makes it easier to init default values
    d['a'].append(1)			# so you can just add items
    d['a'].append(2)			# (w/o checking if list/set exists already)
    d['b'].append(4)
    ...
    e = defaultdict(set)
    e['a'].add(1)
    e['a'].add(2)
    e['b'].add(4)
    ...

>>> d = defaultdict(list)
       for key, value in pairs:
            d[key].append(value)

# 3.2 ordereddict
from collections import OrderedDict

# - preserves original insertion order (useful for serializing/encoding to JSON)
# - twice the size of a regular dict (implemented as a doubly-linked list)

>>> d = OrderedDict()
    d['foo'] = 1
    d['bar'] = 2
    d['spam'] = 3
    d['grok'] = 4
    # Outputs "foo 1", "bar 2", "spam 3", "grok 4"
    for key in d:
         print(key, d[key])

>>> import json
>>> json.dumps(d)
'{"foo": 1, "bar": 2, "spam": 3, "grok": 4}' >>>

# 3.3 using for calculations
# (invert dict into (value, key) pairs using zip())

prices = {
       'ACME': 45.23,
       'AAPL': 612.78,
       'IBM': 205.55,
       'HPQ': 37.20,
       'FB': 10.75
}

>>> min_price = min(zip(prices.values(), prices.keys()))
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
