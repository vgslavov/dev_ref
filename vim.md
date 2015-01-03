## Sources

* [Vim Tutorial and Primer](https://danielmiessler.com/study/vim/)
* [Giant Robots](http://robots.thoughtbot.com/tags/vim)

## Reference

* Verbs (actions)
    * `d`: delete
    * `c`: change
    * `y`: yank (copy)
    * `v`: visually select char (`V` for full line)
* Modifiers (before nouns to describe how to do something)
    * `i`: inside
    * `a`: around
    * `NUM`: number (e.g. 1, 2, 10)
    * `t`: search for something and stop before it
    * `f`: search for something and land on it
    * `/`: find a string (or regex)
* Nouns (objects)
    * `w`: word
    * `s` or `)`: sentence
    * `p` or `}`: paragraph
    * `t`: tag (HTML/XML)
    * `b`: block
* Order: VMN (verb, modifier, noun)
    * `d2w`: delete 2 words
    * `dt.`: delete everything until next period
    * `cis`: change inside sentence [doesn't work]
    * `yip`: yank inside paragraph (copy paragraph you are in)
    * `yt;`: copy to next semicolon
    * `ct(`: change to open parenthesis
* Save and exit
    * `:wq` or `ZZ` (no colon)
* Searching
    * `/{string}`: search for string
    * `t`: jump *up to* a char
    * `f`: jump *onto* a char
    * `*`: search for other instances of word under cursor
    * `n`: go to next instance of search string
    * `N`: go to previous instance of search string
    * `;`: go to next instance of a char (use after `t` or `f`)
    * `,`: go to previous instance of a char (use after `t` or `f`)
* Moving
    * Basic
        * `j`: move down one line
        * `k`: move up one line
        * `l`: move left one char
        * `h`: move right one char
    * Line
        * `0`: move to beginning of line
        * `^`: move to first non-whitespace char of line
        * `$`: move to end of line
    * Word
        * `w`: move forward one word (*to beginning*)
        * `W`: move forward one *big* word (e.g. with -, /, etc.)
        * `b`: move backward one word (*to beginning*)
        * `B`: move backward one *big* word (e.g. with -, /, etc.)
        * `e`: move *to end* of current/next word
    * Sentence/paragraph
        * `)`: move forward one sentence
        * `}`: move forward one paragraph
    * Screen

* Repeat last
    * `.`: edit command
    * ?
* Append text at end of line
```
A
```

* Check syntastic status
```
:SyntasticInfo
```

* List of bundles
```
:BundleList
```

* Force update of bundles
```
:BundleInstall!
```

* If K is bound to silver\_searcher, press when over word to grep for files
containing it
```
K
```

* Copy/paste from/to sys register/clipboard
```
"*p
"*yy
```

* Auto-complete (when spell checking is ON and in INSERT mode only)
```
set complete+=kspell
^N
^P
```

* Add word to spellcheck file (go over it first)
```
zg
```

* Turn on spell checking

```
:setlocal spell
```

* Check what options vim is compiles with
```
vim --version
```

* Need `+clipboard` and maybe `+xterm_clipboard` for copy/paste with system

* Change indentation from 2 to 4 spaces
    * First convert spaces to tabs
    ```
    :set ts=2 sts=2 noet
    :retab!
    ```

    * Then convert tabs to spaces
    ```
    :set ts=4 sts=4 et
    :retab
    ```

* Replace spaces by tabs (^I)
```
:%s/^\([^I]*\)    /\1^I/g
```

* Replace tabs with spaces
```
:retab
```

* Format paragraphs to be 72 chars long
```
!}fmt -w 72
```

* Show line numbers
```
:set nu
```

* Comment N lines (visual block mode)
```
^V      # enter visual block mode
j       # scroll down N lines
l       # if uncommenting multi-char types (e.g. //)

I       # insert (comment)
//      # comment type
#       # or this comment type

d       # or delete (uncomment)
x       # another delete

Esc     # small delay after
```

* Comment N lines
(the pattern between the first two slashes is what you want to replace,
in this case the beginning of the line, and the pattern between the
last two slashes is what you want to replace it with)
```
:.,+N-1 s/^/#/g
```

* Replace all instances of 'foo' with 'bar' on the current line
```
:^,$s/foo/bar/g
```

* Replace all instances of 'foo' with 'bar' from line 1 to the start of
the current line
```
:1,^s/foo/bar/g
```

* Comment every line in a file
```
:%s/^/#/g
```

* Comment lines 5 through 10
```
:5,10s/^/#
```

* Insert "this" at the beginning of every line
```
:%s/^/this/g
```

* Insert "this" at the end of every line
```
:%s/$/this/g
```
