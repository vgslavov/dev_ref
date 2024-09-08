# Idioms in Python

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [The Zen of Python](#the-zen-of-python)
- [Summary](#summary)
- [Sources](#sources)
- [Code](#code)
  - [Truthiness](#truthiness)
  - [`if/for/else` statements](#ifforelse-statements)
  - [Function Arguments](#function-arguments)
  - [Comprehensions](#comprehensions)
  - [Files](#files)
  - [Strings](#strings)
  - [Classes](#classes)
  - [Iterators](#iterators)
  - [Generators](#generators)
  - [Context Managers](#context-managers)
  - [Modules](#modules)
  - [Formatting](#formatting)
  - [Scripts](#scripts)
  - [Exceptions](#exceptions)
- [Binary](#binary)
  - [Operators](#operators)
  - [Manipulating Bits](#manipulating-bits)
  - [Conversions](#conversions)
  - [System Limits](#system-limits)
- [Math](#math)
- [Recipes](#recipes)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## The Zen of Python
(by Tim Peters)

`import this`
> Beautiful is better than ugly.
> Explicit is better than implicit.
> Simple is better than complex.
> Complex is better than complicated.
> Flat is better than nested.
> Sparse is better than dense. 
> Readability counts.
> Special cases aren't special enough to break the rules.
> Although practicality beats purity.
> Errors should never pass silently.
> Unless explicitly silenced.
> In the face of ambiguity, refuse the temptation to guess. 
> There should be one-- and preferably only one --obvious way to do it.
> Although that way may not be obvious at first unless you're Dutch.
> Now is better than never.
> Although never is often better than *right* now.
> If the implementation is hard to explain, it's a bad idea.
> If the implementation is easy to explain, it may be a good idea.
> Namespaces are one honking great idea -- let's do more of those!

## Summary

* readability: avoid clutter, achieve brevity
* but terseness & obscurity make brevity useless
* explicit code
* one statement per line
* function arguments
    * easy to read
    * easy to change
* avoid the magical wand: don't change the way the interpreter works
* we are all consenting adults: rely on a set of conventions
* returning values
    * success
        * single main exit point
    * failure
        * prefer raising an exception
        * as early as possible
        * flatten structure (all following code assumes condition is met)
* avoid assigning to a variable more than once
    * avoid reassigning
    * especially if the type changes

## Sources

* [Writing Idiomatic Python](https://jeffknupp.com/writing-idiomatic-python-ebook/)
* [Python Anti-Patterns](https://docs.quantifiedcode.com/python-anti-patterns/index.html)
* [Python Tips](http://book.pythontips.com/en/latest/index.html)
* http://intermediate-and-advanced-software-carpentry.readthedocs.io/en/latest/
* The Hitchhiker's Guide to Python
* Generator tutorials (by David Beazley)


## Code

### Truthiness

```
False
# all of the below
None
False
0
[]
{}
()

# everything else is implicitly
True

# truth checking
if foo:
    pass
# equality (==): same value
# identity (is): same obj
if my_list:
    pass
# exception: func. arg.
def insert_val(val, pos=None):
    # allows pos == 0
    if pos is not None:
        pass

# check if var eq const (don't compare to True/False)
if attr:
    pass
if not attr:
    pass
if attr is None:
    pass
```

### `if/for/else` statements

* contains: `if in items:`
* iterable: `for x in items:`
* implement `__contains__` in user-defined classes
```
# compound if
if name in ('Tom', 'Tim'):
    is_generic = True
# better
is_generic = name in ('Tom', 'Tim')

# for ... else
for email in addresses:
    if malformed(email):
        print('malformed')
        break
else:
    # executed after iterator is exhausted:
    # i.e. the if condition did not hold for any of the elements
    print('all valid')
```
* ternary operator: `a if condition else b`

### Function Arguments

* default args
```
# always use None for default parameters instead of []!
# * default function values are evaluated only once
# * default values will be shared b/w subsequent calls
# * affects mutable objects: can accumulate args
def f(a, L=None):
    if L is None:
        L = []
    L.append(a)
    return L
```
* passing multiple args
```
# use *args and **kwargs to maintain compatibility
def make_api_call(foo, bar, baz):
    pass
# becomes
def make_api_call(foo, bar, baz, *args, **kwargs):
    baz_coeff = kwargs['the_baz']
```
* unpacking args
```
for i, item in enumerate(some_list):
    print('{} {}'.format(i, item))

# swapping w/o temp vars
a, b = b, a
# works for tuples too
(a, b) = (b, a)

# unpacking using tuples
list_from_csv = ['dog', 'Fido', 10]
(animal, name, age) = list_from_csv

# use _ as placeholder instead of temp vars
(name, age, _, _) = get_user_info(user)

# extended unpacking using tuples (Python 3)
(a, *middle, rest) = [1, 2, 3, 4]
# a = 1, middle = [2, 3], c = 4
(a, middle, *rest) = [1, 2, 3, 4]
# a = 1, middle = 2, rest = [3, 4]

# unpack function args
args = [1, True, "done"]
# function call
func(*args)
# function def
def func(num, bool, str):
    pass

# ignored var (use double _)
filename = 'myfile.txt'
basename, __, ext = filename.rpartition('.')
# __ = '.'
```
* default `dict` args
```
# use default parameter of dict.get to provide default value
d = {'spo_order': 'min'}
print(d.get('spo_order', 'def_value'))  # prints 'spo_order'
print(d.get('g_order', 'def_value'))    # prints 'def_value'

log_severity = config.get('severity', 'Info')

# or
if 'spo_order' in d:
    print(d['spo_order'])
```

### Comprehensions

* list comprehension
```
a = [3, 4, 5]
# build [] on the fly
b = [i for i in a if i > 4]
# filter + lambda
b = filter(lambda x: x > 4, a)

a = [i + 3 for i in a]
# map
a = map(lambda i: i + 3, a)
# don't use a manual counter
for i, item in enumerate(a, start=1):
    print('{0}, {1}'.format(i, item))

# n-length list of same thing (lists are mutable)
four_nones = [None] * 4

# n-length list of lists
four_lists = [[] for __ in range(4)]
```
* dict comprehension
```
user_email = {user.name: user.email
            for user in users_list if user.email}
```
* set comprehension
```
users_first_names = {user.first_name for user in users}
```
* set operations
    * sets are dicts w/o keys & use `{}` just like `dict`
    * use *bitwise* operators on sets
        * union: A | B
        * intersection: A & B
        * difference: A - B (order matters)
        * symmetric difference: A ^ B (the set of el. in either A or B but not both)

### Files
```
# read from a file (closes cleanly even if exception)
with open('file.txt') as f:
    for line in f:
        print(line)
```

### Strings

* immutable!
* `string.ascii_lowercase`: English alphabet
```
# read file as a string
contents = ''.join(open('file.txt').read().splitlines())
# line continuation
long_string = (
    "For a long time I used to go to bed early. Sometimes, "
    "when I had put out my candle, my eyes would close so quickly "
    "that I had not even time to say “I’m going to sleep.”"
)

# concat-ing strings
# OK: append
nums = []
for n in range(20):
    nums.append(str(n))
# Best: list comprehension
nums = [str(n) for n in range(20)]
print(''.join(nums))

# building strings
letters = ['s', 'p', 'o']
word = ''.join(letters)

# join is not always best
foo = 'foo'
bar = 'bar'
# Better: a new string from a pre-determined # of strings, use addition
foobar = foo + bar
# or Best: a new string from a pre-determined # of strings, use format
foobar = '{0}{1}'.format(foo, bar)
foobar = '{foo}{bar}'.format(foo=foo, bar=bar)
# Best: adding to an existing string, use str.join()
foo = ''.join([foo, 'ooo'])

# chain string functions (no more than 3)
formatted_book_info = book_info.strip().upper().replace(':', ' by')
```

### Classes

```
# mark private data with underscores as prefix
# protected (not used by clients): one _
# effect: won't be imported if 'all' is used
_ssid = ssid
# private (not used by subclasses): two _
# effect: name mangling will be applied to make it less useful
__id = id

# define __str__ in a class so print() works on those objects
def __str__(self):
    return '{0}, {1}'.format(self.x, self.y)
```

### Iterators

* `iter`: iterate over any object
```
it = iter(l)
next(it)        # only supported method
```
* looping
```
for i in iter(obj):
    print(i)
# same as
for i in obj:
    print(i)
```
* can go only forward, can't go back!
* data types: lists, tuples, any sequence, dict

### Generators

* use a generator to lazily load (iterate over) infinite sequences
`yield do(whatever)`
* instead of
`return do(whatever)`
* regular functions compute a value and return it
* generators return an iterator that returns a stream of values
* prefer **generator expressions** to **list comprehensions** for a simple iteration
    * generator expressions return iterators, surrounded by `()`
      `strip_iter = (line.strip() for line in line_list)`
    * list comprehensions return lists, surrounded by `[]`
      `strip_list = [line.strip() for line in line_list)`
* `filter` vs generator expressions
    * `filter(function, iterable)`
    * `(item for item in iterable if function(item))`
    * `(item for item in iterable if item)`: if function is `None`
* bad: list comprehension (uses [])
```
names = [name.upper() for name in get_all_usernames()]
for uppercase_name in names:
    process_normalized_username(uppercase_name)
```
* best: generator expression (uses ())
* generates elements on-demand: faster
```
names = (name.upper() for name in get_all_usernames())
for uppercase_name in names:
    process_normalized_username(uppercase_name)
```
* sum up last column in a large file
```
# awk solution
cmd = "awk '{ total += $NF } END { print total }' big-access-log"
os.system(cmd)

# line-by-line solution
wwwlog = open("access-log")
total = 0
for line in wwwlog:
    bytestr = line.rsplit(None,1)[1]
    if bytestr != '-':
        total += int(bytestr)
print("Total {0}".format(total))

# generator solution
wwwlog = open("access-log")
bytecolumn = (line.rsplit(None,1)[1] for line in wwwlog)
bytes = (int(x) for x in bytecolumn if x != '-')
print("Total {0}".format(sum(bytes)))
```

### Context Managers

```
# use a context manager ('with') to enforce RAII
# (especially when raising exceptions)
# user-defined classes should define __enter__ and __exit__ to do the same
with open(path_to_file, 'r') as file_handle:
    for line in file_handle:
        if raise_exception(line):
            print('exception')
```

### Modules

* use 'modules' for encapsulation where other languages would use Objects
* store most data in the following types
    * list
    * dict
    * set
* use classes only when necessary and never at API boundaries
* example: MVC web framework to build 'Chirp'
* a *package* 'chirp' with 'model', 'view', and 'controller' *modules*
* if big project, the modules can be packages too
* the 'controller' package may have a 'persistence' and a 'processing' module
* this way interoperability is preserved
* code sharing and encapsulation using: `import me`
* passing state by passing args to functions (loose coupling)
* Object Oriented Programming is not the *only* paradigm
* prefer absolute imports to relative imports to prevent clutter
`import package.other_module`
* or use as for brevity
`import package.other_module as other`
* do not use `from foo import *` to import a module
`from foo import (bar, baz, qux, quux)`
* even better
`import foo`
* Python FAQ: 'Never use relative package imports'
* arrange import statements:
    1. standard  lib modules
    2. 3rd party lib modules installed in site-packages
    3. modules local to current project
* within those, order in alpha order (or whatever else makes sense)
* learn the contents of the Python Standard Library (to avoid reinventing the wheel)
* get to know PyPI (the Python Package Index)
* modules of note
    * `import itertools`: see recipes
    * when working with dir paths: `import os.path`

### Formatting

```
# global constants are in ALL CAPS
SECONDS_IN_A_DAY = 60 * 60 * 24

# one statement per line
if bad_code:
    rewrite_code()

# format code according to PEP8
# class: Camel case
class StringManipulator():
    pass
# variable: words joined by _
join_by_underscore = True
# function: words joined by _
def multi_word_name(words):
    pass
# constant: all uppercase
SECRET_KEY = 42
# everything else: words joined by _
```

### Scripts

* run with `#!/usr/bin/env python3`
* use `sys.exit` in scripts to return proper error codes
  (allows running script in UNIX pipes)
* make script both importable & executable
```
def main():
    import sys
    if len(sys.argv) < 2:
        # prints string to stderr
        # exits with a value of '1' (error)
        sys.exit('not enough args')

    arg = sys.argv[1]
    result = do_stuff(arg)
    if not result:
        sys.exit(1)

    # optional, defaults to None (same as 'exit with 0')
    return 0

if __name__ == '__main__':
    sys.exit(main())

# to be able to both import and run directly a script, use:
if __name__ == '__main__':
    pass
# when imported: 'libs' which are imported will not exececute code under if
# when run directly: only code under if will be executed
```

### Exceptions

* prefer EAFP (Easier to Ask for Permission) to LYBL (Look Before You Leap)
* exceptions are not expensive
* don't check for specific types, rely on duck typing
```
d = {'x': '5'}
try:
    value = int(d['x'])
except (KeyError, TypeError, ValueError):
    value = None
```

## Binary

* Python has no *unsigned* data types!
* right-most bit is least-significant (LSB)
* LSB determines if number is odd or even: 2^0 = 1
  (all other bits are even: 2^1, 2^2, etc.)
* `(8).bit_length()`: show # of binary digits

### Operators

* bitwise operators take precedence over comparison operators: use `()`
* logical operators are evaluated *lazily*, bitwise operators are evaluated *eagerly*
* modulo operator (`%`): perform division and return remainder (`125 % 10 = 5`)
* bitwise AND: `&`
    * logical conjunction
    * intersection
    * `(a & b) = a * b`
* bitwise OR: `|`
    * logical disjunction
    * union
    * `(a | b) = a + b - (a * b)`
* bitwise XOR: no operator
    * exclusive disjunction
    * symmetric difference
    * `(a and not b) or (not a and b)`
    * `(a ^ b) = (a + b) mod 2`
    * if # of 1s is odd, result is 1; otherwise, 0
    * `x ^ x = 0`
    * `0 ^ y = y`
    * `x ^ x ^ y = y`
* bitwise NOT: `~`
    * complement
    * unary
    * subtraction
    * `~a = 1 - a`
    * `~156 & 255`: use bitmask to preserve size of bit pattern
* left shift: `<<`
    * multiply by powers of two
    * shifts bits to left
        * drops left-most bits
        * 0-pads bits on the right
    * `a << n = a * 2^n`
    * `(39 << 3) & 255`: use bitmask to preserve size of bit pattern
* right shift: `>>`
    * *floor* division by powers of two
    * shifts bits to right
        * drops right-most bits
        * 0-pads bits on the left
    * `a >> n = floor(a / 2^n)`
    ```
    5 >> 1     # 2: bitwise right shift
    5 // 2     # 2: floor (integer) division (let's you choose divisor)
    5 /  2     # 2.5: floating-point division
    ```
    * no need to bitmask to preserve size of bit pattern
        * `8 >> 2`
        * `1000` -> `0010`

### Manipulating Bits

* test bit: `value & (1 << offset)`
* test normalized bit: `(value >> offset) & 1`
* set bit: `value | (1 << offset)`
* clear bit: `value & ~(1 << offset)`
* toggle bit: `value ^ (1 << offset)`

### Conversions

* `id`: check an object's identity in memory
```
a = 5
b = a
a is b          # True
id(a) == id(b)  # True
```
* `bin(5)`: int to binary `int('101', 2)`: binary to int
* `hex(10)`: int to hexadecimal `int('a', 16)`: hex to int
* `oct(10)`: int to octal `int('12', 8)`: oct to int

### System Limits

* `sys.maxsize`max fixed-precision integer
* `-sys.maxsize-1`: min fixed-precision integer
* `sys.int_info`: bits per digit, max str digits, etc.
* `sys.byteorder`: little or big-endian

## Math

* use `math.inf` for comparing to big/small numbers (`-math.inf`)
* `is_integer()`: is a float an integer?

## Recipes

```
# sorted, unique list
# TODO: does it only work for hashables types (strings, numbers, tuples)?
my_list = sorted(set(my_list))

# sort dictionary into tuples, by value in reverse
sorted(d.items(), key=itemgetter(1), reverse=True)

# skip first item in seq
for w in words[1:]:
    pass

# skip first item in any container
iter_words = iter(words)
next(iter_words)
for w in iter_words:
    pass

# capitalize words in a string
title = 'the brown fox'
# simple
title.title()
# better
' '.join([w.capitalize() for w in title.split()])

# reverse string
title = "example"
title[::-1]

# go over two lists
for f, b in zip(foo, bar):
    pass

# create dict from keys and values
keys = ['Modern', 'Old', 'New']
values = ['Talking', 'Testament', 'Order']
d = dict(zip(keys, value))

# division
# Python 2: both int, result int
10 / 3      # 3
# Python 3: both int, result float
10 / 3      # 3.3333333333333335
10 // 3     # 3
10 // 3.0   # 3.0

# slices
nums = [0, 1, 2, 3, 4, 5]
# slices are include 1st element but exclude last: [1st, last)
a = nums[2:4]      # 2, 3
MID = slice(2, 4)
MID.start          # 2
MID.stop           # 4
b = nums[MID]      # 2, 3
```
