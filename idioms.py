#!/usr/bin/env python3

'''
- readability: avoid clutter, achieve brevity
- but terseness & obscurity make brevity useless
- explicit code
- one statement per line
- function arguments
  - easy to read
  - easy to change
- avoid the magical wand
  (e.g. don't change the way the interpreter works, etc.)
- we are all consenting adults: rely on a set of conventions
- returning values
  - success
    - single main exit point
  - failure
    - prefer raising an exception
    - as early as possible
    - flatten structure (all following code assumes condition is met)
- avoid assigning to a variable more than once
  - avoid reassigning
  - especially if the type changes

Sources:
- Writing Idiomatic Python (by Jeff Knupp)
- The Hitchhiker's Guide to Python
- Generator tutorials (by David Beazley)
- stackoverflow.com
'''


False
# all of the below
None
False
0
[]
{}
()

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
    # the if condition did not hold for any of the elements
    print('all valid')

# always use None for default parameters instead of []!
def f(a, L=None):
    if L is None:
        L = []
    L.append(a)
    return L

# use *args and **kwargs to maintain compatibility
def make_api_call(foo, bar, baz):
    pass
# becomes
def make_api_call(foo, bar, baz, *args, **kwargs):
    baz_coeff = kwargs['the_baz']

# unpacking
for index, item in enumerate(some_list):
    print('{} {}'.format(index, item))

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

# n-length list of same thing (lists are mutable)
four_nones = [None] * 4

# n-length list of of lists
four_lists = [[] for __ in range(4)]

# building strings
letters = ['s', 'p', 'o']
word = ''.join(letters)

# zen of python
import this

# check if var eq const (don't compare to True/False)
if attr:
    pass
if not attr:
    pass
if attr is None:
    pass

# access a dict el
d = {'spo_order': 'min'}
print(d.get('spo_order', 'def_value'))  # prints 'spo_order'
print(d.get('g_order', 'def_value'))    # prints 'def_value'

# assign Info if severity not set
log_severity = config.get('severity', 'Info')

# or
if 'spo_order' in d:
    print(d['spo_order'])

a = [3, 4, 5]
# list comprehension
b = [i for i in a if i > 4]
# filter + lambda
b = filter(lambda x: x > 4, a)

# list comprehension
a = [i + 3 for i in a]
# map
a = map(lambda i: i + 3, a)
# don't use a manual counter
for i, item in enumerate(a, start=1):
    print('{0}, {1}'.format(i, item))

# dict comprehension
user_email = {user.name: user.email
              for user in users_list if user.email}

# read from a file (closes cleanly even if exception)
with open('file.txt') as f:
    for line in f:
        print(line)

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

# join is not always best
foo = 'foo'
bar = 'bar'
# Best: a new string from a pre-determined # of strings, use addition
foobar = foo + bar
# or Best: a new string from a pre-determined # of strings, use format
foobar = '{0}{1}'.format(foo, bar)
foobar = '{foo}{bar}'.format(foo=foo, bar=bar)
# Best: adding to an existing string, use str.join()
foo = ''.join([foo, 'ooo'])

# chain string functions (no more than 3)
formatted_book_info = book_info.strip().upper().replace(':', ' by')

# mark private data with underscores
# protected (not used by clients): one _
# effect: won't be imported if 'all' is used
_ssid = ssid
# private (not used by subclasses): two _
# effect: name mangling will be applied to make it less useful
__id = id

# define __str__ in a class so print() works on those objects
def __str__(self):
    return '{0}, {1}'.format(self.x, self.y)

# set comprehension
# (sets use {} just like dicts!)
users_first_names = {user.first_name for user in users}

# sets are dicts w/o keys
# union: A | B
# intersection: A & B
# difference: A - B (order matters)
# symmetric difference: A ^ B (the set of el. in either A or B but not both)

# use a generator to lazily load infinite sequences

# prefer generator expressions to list comprehensions for a simple iteration
# bad: list comprehension
for uppercase_name in [name.upper() for name in get_all_usernames()]:
    process_normalized_username(uppercase_name)
# best: generator expression
for uppercase_name in (name.upper() for name in get_all_usernames()):
    process_normalized_username(uppercase_name)

# use a context manager ('with') to enforce RAII
# (especially when raising exceptions)
with open(path_to_file, 'r') as file_handle:
    for line in file_handle:
        if raise_exception(line):
            print('exception')

# use 'modules' for encapsulation where other languages would use Objects
# store most data in the following types:
list
dict
set
# use classes only when necessary and never at API boundaries
# example: MVC web framework to build 'Chirp'
# a *package* 'chirp' with 'model', 'view', and 'controller' *modules*
# if big project, the modules can be packages too
# the 'controller' package may have a 'persistence' and a 'processing' module
# this way interoperability is preserved
# code sharing and encapsulation using:
import me
# passing state by passing args to functions (loose coupling)
# Object Oriented Programming is not the *only* paradigm

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

# use sys.exit in scripts to return proper error codes
# (allows running script in UNIX pipes)
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
# 'libs' which are imported will not exececute code under if
# when run directly, only code under if will be executed

# prefer absolute imports to relative imports to prevent clutter
import package.other_module
# or use as for brevity
import package.other_module as other

# do not use 'from foo import *' to import a module
from foo import (bar, baz, qux, quux)
import foo

# arrange import statements:
# 1. standard  lib modules
# 2. 3rd party lib modules installed in site-packages
# 3. modules local to current project
# within those, order in alpha order (or whatever else makes sense)

# learn the contents of the Python Standard Library
# (to avoid reinventing the wheel)

# get to know PyPI (the Python Package Index)

# modules of note
import itertools
# when working with dir paths
import os.path

##

# deep copy of lists
a = [1, 2, 3]
b = a[:]
c = list(a)
# exception: collections of mutable objs (those objs remain as refs)
d = [[1, 2], 3]
e = deepcopy(d)

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

# division
# Python 2: both int, result int
10 / 3      # 3
# Python 3: both int, result float
10 / 3      # 3.3333333333333335
10 // 3     # 3
10 // 3.0   # 3.0

## generators (by David Beazley)

# sum up last column in a large file

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

