# use regcomp(3) and regexec(3) in C

# only digits (at least one)
^[0-9]+$

# at least one character long string that includes upper/lower case
# letters and digits between 0 and 9
^[A-Za-z0-9]+$

# file name pattern
^[A-Za-z0-9][A-Za-z0-9._\-]*$

# locale pattern
^[A-Za-z0-9][A-Za-z0-9_,+@\-\.=]*$

# http pattern (simple)
^(http|ftp|https)://[-A-Za-z0-9._/]+$

# http pattern (complex)
^(http|ftp|https)://[-A-Za-z0-9._]+(\/([A-Za-z0-9\-\_\.\!\~\*\'\(\)\%\?]+))*/?$

# zero or more
*

# one or more
+

# zero or one
?

# validating Roman numerals [M{0,4} or M{0,3}]
^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$

# validating Roman numerals with Python verbose regular expressions
pattern = """
    ^                   # beginning of string
    M{0,4}              # thousands - 0 to 4 M's
    (CM|CD|D?C{0,3})    # hundreds - 900 (CM), 400 (CD), 0-300 (0 to 3 C's),
                        #            or 500-800 (D, followed by 0 to 3 C's)
    (XC|XL|L?X{0,3})    # tens - 90 (XC), 40 (XL), 0-30 (0 to 3 X's),
                        #        or 50-80 (L, followed by 0 to 3 X's)
    (IX|IV|V?I{0,3})    # ones - 9 (IX), 4 (IV), 0-3 (0 to 3 I's),
                        #        or 5-8 (V, followed by 0 to 3 I's)
    $                   # end of string
    """
# always read regular expressions from left to right

# validating phone numbers with Python verbose regular expressions
phonePattern = re.compile(r'''
                # don't match beginning of string, number can start anywhere
    (\d{3})     # area code is 3 digits (e.g. '800')
    \D*         # optional separator is any number of non-digits
    (\d{3})     # trunk is 3 digits (e.g. '555')
    \D*         # optional separator
    (\d{4})     # rest of number is 4 digits (e.g. '1212')
    \D*         # optional separator
    (\d*)       # extension is optional and can be any number of digits
    $           # end of string
    ''', re.VERBOSE)

# ^ matches the beginning of a string.
# $ matches the end of a string.
# \b matches a word boundary.
# \d matches any numeric digit.
# \D matches any non-numeric character.
# x? matches an optional x character (in other words, it matches an x
zero or one times).
# x* matches x zero or more times.
# x+ matches x one or more times.
# x{n,m} matches an x character at least n times, but not more than m
times.
# (a|b|c) matches either a or b or c.
# (x) in general is a remembered group. You can get the value of what
matched by using the groups() method of the object returned by
re.search.

# I recommend always using raw strings when dealing with regular expressions;
# otherwise, things get too confusing too quickly
# (and regular expressions are confusing enough already).
re.sub(r'\bROAD\b', 'RD.', s)

