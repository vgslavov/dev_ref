# vim:ts=4
# disclaimer: some of these observations are extremely obvious;
# also, most of them have been copied from books or from the Internet

sys.path.insert(0, '/Users/vgs/Documents/Python/books/diveintopython3/examples')

Python functions have attributes, and those attributes are available at runtime.

A function, like everything else in Python, is an object.

Python uses carriage returns to separate statements and a colon and indentation to separate code blocks. C++ and Java use semicolons to separate statements and curly braces to separate code blocks.

Python encourages the use of exceptions, which you handle.

Python uses try...except blocks to handle exceptions, and the raise statement to generate them. Java and C++ use try...catch blocks to handle exceptions, and the throw statement to generate them.

You don’t need to handle an exception in the function that raises it. If one function doesn’t handle it, the exception is passed to the calling function.

Unlike C, Python does not support in-line assignment, so there’s no chance of accidentally assigning the value you thought you were comparing.

use the type() function to check the type of any value or variable (e.g. int, str, class, module)

use the isinstance() function to check whether a value or variable is of a given type

# x == 1/3
x = fractions.Fraction(1, 3)

a_list[-n] == a_list[len(a_list) - n]

Reading the list from left to right, the first slice index specifies the first item you want, and the second slice index specifies the first item you don’t want. The return value is everything in between.

a_list[:n] will always return the first n items, and a_list[n:] will return the rest, regardless of the length of the list

a_list[:] is shorthand for making a complete copy of a list

A list can contain items of any datatype, and the items in a single list don’t all need to be the same type.

Tuples are faster than lists (but are immutable).

tuple() freezes a list, and list() thaws a tuple.

Lists can never be used as dictionary keys (most tuples can).

To create a tuple of one item, you need a comma after the value. Without the comma, Python just assumes you have an extra pair of parentheses, which is harmless, but it doesn’t create a tuple.

v = ('a', 2, True)
(x, y, z) = v

since sets are unordered, there is no “last” value in a set, so there is no way to control which value gets removed/pop()-ed

None != False
None != 0
None != “”

print(os.path.join(os.path.expanduser('~'), 'diveintopython3', 'examples', 'humansize.py'))
(dirname, filename) = os.path.split(pathname)
(shortname, extension) = os.path.splitext(filename)
glob.glob('examples/*.xml')
print(os.path.realpath('feed.xml'))

[Dictionary comprehension is] similar to a list comprehension, with two differences. First, it is enclosed in curly braces instead of square brackets. Second, instead of a single expression for each item, it contains two expressions separated by a colon. The expression before the colon (f in this example) is the dictionary key; the expression after the colon (os.stat(f) in this example) is the value.

swapping keys and values in a dict:
>>> a_dict = {'a': 1, 'b': 2, 'c': 3}
>>> {value:key for key, value in a_dict.items()}
{1: 'a', 2: 'b', 3: 'c'}

grab a data struct defined in a module:
>>> import humansize
>>> si_suffixes = humansize.SUFFIXES[1000]

"{0}'s password is {1}".format(username, password)

>>> import humansize
>>> import sys
>>> '1MB = 1000{0.modules[humansize].SUFFIXES[1000][0]}'.format(sys)

Bytes are bytes; characters are an abstraction. An immutable sequence of Unicode characters is called a string. An immutable sequence of numbers-between-0-and-255 is called a bytes object.

by = b'abcd\x65'

And here is the link between strings and bytes: bytes objects have a decode() method that takes a character encoding and returns a string, and strings have an encode() method that takes a character encoding and returns a bytes object.

star unpacking:                 
>>> line = 'nobody:*:-2:-2:Unprivileged User:/var/empty:/usr/bin/false' 
>>> uname, *fields, homedir, sh = line.split(':')

%
import rdflib
rdflib.__version__
%
myobject.__dict__
%
print function.__doc__
%
everything is an object, even ";"
%
list filtering syntax:
[mapping-expression for element in source-list if filter-expression]
%
and-or trick (ala bool ? a : b):
1 and a or b
0 and a or b
note: "a" HAS to be true
instead do:
(1 and [a] or [b])[0]
%
and, or return one of the actual values, rather than a boolean value
%
and:
if all values are true, return the last value
if any value is false, return the first false value

or:
if any value is true, return that value
if all values are false, return the last value
%
read list comprehensions from right to left (or start from the for part:
in the middle)
%
import module vs. from module import (for the latter, don't need to
qualify by module name when calling)
%
normalize whitespace (split a string and rejoin):
print " ".join(s.split())
%
open, read, and print file:
print file('test.log').read()
%
*reading doc strings (import the appropriate module first):
print open.__doc__
%
data attributes:
- owned by a specific instance of the class
- defined in __init__
class attributes:
- owned by the class itself
- exist even before any instances are created
- defined immediately after class definition
- available both through direct reference to the class and through any
  instance of the class
- used as class-level constants
- shared by the class and all instances of the class
%
pydoc str
%
help(str)
%
pydoc
%
import this
%
to find the methods of an object:
l = []
dir(l)
%
tuples ~ C structs
lists ~ arrays
%
iterate over the keys of a dictionary in sorted order

keys = dict.keys()
keys.sort()
for key in keys:
    ...
%
string -> number:
int(string, base), float(string, base)
%
number -> string:
str(), hex(), oct()
%
arguments are passed by assignment (assignments create references to
objects) in Python (no call-by-reference per se)
%
to convert a sequence to a tuple: tuple(seq), to a list: list(seq)
%
all of the string except the last character: s[:-1]
%
compile all files in current directory:
python /path/to/compileall.py .
%
identifiers (name used to id. variables, functions, classes, modules,
etc.):
- single leading underscore: private
- two leading underscores: strongly private
- two leading + two ending underscores: language-defined special name
- "_": interpreter binds to result of last expression statement
%
no concept of protected (accessible only in their own class and
descendant classes)
%
private: accessible only in their own class
public: accessible anywhere
%
a Python floating-point value = a C double (same limits of range and
precision)
%
immutable: numbers, (unicode) strings, tuples (), some class instances,
combinations
mutable: lists [], dictionaries {}, most classes and class instances
%
raw strings (e.g. r"something\\\\klj") cannot end with an odd number of
backslashes
%
multiple string literals of any kind can be adjacent, with optional
white space in between
%
python -c "import this"
%
string methods (e.g. join, split, find, replace, startswith, endswith) are
favored over the string module
%
avoid '+'; especially in loops (strings (immutable) will get copied);
use interpolation and?or join()
%
no function overloading
%
bad behavior is discouraged but not banned
%
private/public of function, method, attribute is determined by its name
only
%
import string
def normalize_whitespace(text):
    "Remove redundant whitespace from a string"
    return ' '.join(text.split())
%
li[-n] == li[len(li) - n]
%
returns the first n elements:
li[:n]
returns the rest:
li[n:]
shorthand for making a _complete_ copy of li (rather than a reference):
li[:]
make a _complete_ copy of a dictionary:
dict.copy()
%
list elements do not need to be unique
%
(userCount,)    a tuple with one element (the comma IS required)
%
anystring.split(delimiter, 1)

is a useful technique when you want to search a string for a substring
and then work with everything before the substring (which ends up in the
first element of the returned list) and everything after it (which ends
up in the second element).
%
cool methods:
getattr():
gets a reference to an object by name; allows you to access arbitrary
functions dynamically by providing the function name as a string
hasattr():
checks whether an object has a particular attribute
type()
property()
%
li.pop     a reference to the pop method of a list
vs.
li.pop()    calling the pop method
%
getattr(object, "attribute") == object.attribute
%
filtering:
    mapping-expression for element in source-list if filter-expression
%
the expression getattr(object, method) returns a function object if
object is a module and method is the name of a function in that module
%
s.split() (w/o arguments) splits on whitespace
%
"is None" is faster than "== None"
%
    print "\n".join(li)
%
assigning functions to variables and calling the function by referencing
the variable
%
code in the finally block will always be executed, even if something in
the try block raises an exception
%
instead of this:
    for i in range(len(li)):
       print li[i]

do this:
    for s in li:
       print s
%
instead of this:
    for k, v in os.environ.items():
       print "%s=%s" % (k, v)
do this:
    print "\n".join(["%s=%s" % (k, v)
       for k, v in os.environ.items()])
%
use the functions in os and os.path for file, directory, and path
manipulations
%
glob.glob():
takes a wildcard and returns the full path of all files and directories
matching the wildcard
%
subclass = "%sFileInfo" % os.path.splitext(filename)[1].upper()[1:]:
It gets the extension of the file (os.path.splitext(filename)[1]),
forces it to uppercase (.upper()), slices off the dot ([1:]), and
constructs a class name out of it with string formatting. So
c:\music\ap\mahadeva.mp3 becomes .mp3 becomes .MP3 becomes MP3 becomes
MP3FileInfo.
%
always use raw strings (r'\bROAD$') when dealing with regular expressions
%
re.search(pattern, string)
or
pattern = re.compile(r'some pattern')
pattern.search(string).groups()
%
Python is better at lists than strings because the former are mutable,
and the latter are immutable. Appending n items to a list is O(n)
(add the element and update the index); appending n items to a string is
O(n^2) (expensive memory management: creation of an entirely new string)
%
locals() and globals() return a dictionary with keys, variable names,
and values, the actual values of the variables of the caller

locals() is read-only: it returns a copy of the local namespace
globals() is not read-only: it returns the actual global namespace
%
in-order search of namespaces:
1. local namespace - specific to the current function or class
method. If the function defines a local variable x, or has an
argument x, Python will use this and stop searching.
2. global namespace - specific to the current module. If the
module has defined a variable, function, or class called x, Python
will use that and stop searching.
3. built-in namespace - global to all modules. As a last
resort, Python will assume that x is the name of built-in
function or variable.
%
Python has dynamic typing
%
dictionary-based string formatting:
text = "some text"
list.append("<!--%(text)s-->" % locals())
%
try...except...else:
the else is executed if no exception was raised
%
reloading modules from the command line (imports only work the first
time):
reload(module)
%
statements cannot appear where expressions are expected, and an
assignment is not an expression
%
incorrect:
D = {...}
for k in D.keys().sort(): print D[k]

correct:
Ks = D.keys()
Ks.sort()
for k in Ks: print D[k]
%
explicit is better than implicit (EIBTI)
%
defaults retain the same object between calls (be careful when changing
mutable objects):

incorrect:
def saver(x=[]):    # Saves away a list object
    x.append(1)    # and changes it each time
    print x

correct:
def saver(x=None):
    if x is None: x = []   # No arg passed?
    x.append(1)            # Changes new list
    print x
%
Empty except clauses in try statements may catch more than you expect.
An except clause in a try that names no exception catches every
exception -- even things like genuine programming errors, and the
sys.exit() call.
%
any level of a package can be treated as a package
%
a Document always has only one child node, the root element of the XML
document
%
sys.getdefaultencoding()
%
always access individual attributes by name, like the keys of a
dictionary (rather than by indexing, because the order is undefined)
%
print >> sys.stderr, 'entering function'
%
getopt():
the order of short and long flags needs to be the same, so you'll need
to specify all the short flags that do have corresponding long flags
first, then all the rest of the short flags
%
import xml
xml.__version__
%
switch statement Python idiom: hash table, not if-then statements
%
sys.path
%
getElementsByTagName() returns an emtpy list ([]) if tag is not found
%
create and execute a name of a function/object:
    eval("reply%s" % child)
%
how cool is that:
    sess['list'].sort(lambda x, y: cmp(x['room'], y['room']))
%
instead of this:
    map(function, alist)
use this (list comprehension):
    function(x) for x in alist
%
results = [(x, y)
               for x in range(10)
               for y in range(10)
               if x + y == 5
               if x > y]
%
def quicksort(lst):
    if len(lst) == 0:
       return []
    else:
       return quicksort([x for x in lst[1:] if x < lst[0]]) + [lst[0]] + \
              quicksort([x for x in lst[1:] if x >= lst[0]])
%
use of map, recude, and filter:
    lst1 = [1, 2, 3, 4, 5]
    lst2 = [6, 7, 8, 9, 10]
    lst_elementwise_sum = map(lambda x, y: x + y, lst1, lst2)
    lst1_sum = reduce(lambda x, y: x + y, lst1)
    nums = range(101)
    odd_nums = filter(lambda x: x % 2 == 1, nums)
%
lexical scoping
%
Wrong: for s in strings: result += s
Right: result = ''.join(strings)
%
test objects for identity, rather than equality:
    if x in not None
rather than
    if x != None

# for profiling, use profile.py

Invert a dictionary that has lists as its values. For example,
convert {A:[1,2,3], B:[4]} into {1:A, 2:A, 3:A, 4:B}.
This assumes that all the items in the value-lists are unique.
    def invert(d):
       return dict((v,k) for k in d for v in d[k])
