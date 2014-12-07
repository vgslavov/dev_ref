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
- avoid assinging to a variable more than once
  - avoid reassigning
  - especially if the type changes
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
# equality (==): same value
# identity (is): same obj
if my_list:
# exception: func. arg.
def insert_val(val, pos=None):
    # allows pos == 0
    if pos is not None:

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
# becomes
def make_api_call(foo, bar, baz, *args, **kwargs):
    baz_coeff = kwargs['the_baz']

# unpacking
for index, item in enumerate(some_list):
    print('{} {}'.format(index, item))

# swapping
a, b = b, a

# extended unpacking (Python 3)
(a, *middle, rest) = [1, 2, 3, 4]
# a = 1, middle = [2, 3], c = 4
(a, middle, *rest) = [1, 2, 3, 4]
# a = 1, middle = 2, rest = [3, 4]

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
    print d['spo_order']

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
    print i, item

# dict comprehension
user_email = {user.name: user.email
              for user in users_list if user.email}

# read from a file (closes cleanly even if exception)
with open('file.txt') as f:
    for line in f:
        print line

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

# generators (by David Beazley)

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
print "Total", total

# generator solution
wwwlog = open("access-log")
bytecolumn = (line.rsplit(None,1)[1] for line in wwwlog)
bytes = (int(x) for x in bytecolumn if x != '-')
print "Total", sum(bytes)
