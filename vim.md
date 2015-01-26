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
* Order: *VMN* (verb, modifier, noun)
    * `d2w`: delete 2 words
    * `dt.`: delete everything until next period
    * `cis`: change inside sentence (replace current full sentence)
    * `yip`: yank inside paragraph (copy paragraph you are in)
    * `yt;`: copy to next semicolon
    * `ct(`: change to open parenthesis
* Save & exit
    * `:wq`
    * `ZZ` (no colon)
* Search
    * `/{string}`: search for {string}
    * `t`: jump *up to* a char
    * `f`: jump *onto* a char
    * `*`: search for other instances of word under cursor
    * `n`: go to next instance of search string
    * `N`: go to previous instance of search string
    * `;`: go to next instance of a char (use after `t` or `f`)
    * `,`: go to previous instance of a char (use after `t` or `f`)
    * `K`: grep for files containing the word under cursor
      (requires silver\_searcher)
* Move
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
        * `H`: move to top (*high*)
        * `M`: move to middle
        * `L`: move to bottom (*low*)
        * `gg`: go to top of file
        * `G`: go to bottom of file
        * `^U`: move *up* half a screen
        * `^D`: move *down* half a screen
        * `^F`: page down (*forward*)
        * `^B`: page up (*backwards*)
        * `^E`: scroll up one line
        * `^I`: scroll down one line
    * Jump
        * `^i`: jump to previous navigation location
        * `^o`: jump back to where you were
        * `30G`: jump to line # 30
        * `:30`: jump to line # 30
* Change/insert (all enter Insert mode)
    * `i`: *insert* before the cursor
    * `a`: *append* after the cursor
    * `I`: *insert* at the beginning of the line
    * `A`: *append* at the end of the line
    * `o`: *open* a new line below the current one
    * `O`: *open* a new line above the current one
    * `r`: *replace* only the char under the cursor
    * `R`: *replace* the char under the cursor and following until `Esc`
    * `c{m}`: *change* whatever you use as a *movement* `{m}` (e.g. `w`, `$`)
    * `C`: *change* current line (from cursor to end of line)
    * `s`: *substitute* from cursor to next command (noun) [doesn't work?]
    * `S`: *substitute* current line
    * `~`: change case (toggle)
* Format
    * `gq ap`: format *around paragraph* (`ap`) according to `textwidth` setting
    * `!}fmt -w 72`: format paragraph (`}`) to be 72 chars wide
      (can be line (`$`), sentence (`)`), etc.)
* Delete
    * `x`: *exterminate* char under cursor
    * `X`: *exterminate* char before cursor
    * `d{m}`: *delete* whatever you use as a *movement* `{m}` (e.g. `w`, `}`)
    * `dd`: *delete* current line
    * `D`: *delete* to end of line
    * `J`: *join* current line with next one (delete what's b/w)
* Undo/redo (can use repeatedly to go back or forward)
    * `u`: *undo* last action
    * `^r`: *redo* last action
* Repeat
    * `.`: repeat last action (edit command?)
        ```
        dw      # *delete* a *word*
        5.      # delete 5 more words
        ```

        ```
        /delinquent             # search for a word
        A[DO NOT PAY] [Esc]     # *append* text to end of line
        n.                      # repeat on all other instances
        ```
    * `&`: repeat last `ex` command?
* Copy/paste
    * `y`: *yank* selected text
    * `yy`: *yank* current line
    * cutting is the same as deleting (deleted text is stored into a buffer)
    * `p`: *paste* copied (or deleted) text after the cursor position
    * `P`: *paste* copied (or deleted) text before the cursor position
        * `ddp`: swap current line with next
    * `"*yy`: copy to sys register/clipboard
    * `"*p`: paste from sys register/clipboard
      (need `+clipboard` and maybe `+xterm_clipboard`)
    * `vim --version`: check options `vim` is compiled with
* Spell check
    * `:set {no}spell`: enable/disable spell check
    * `:setlocal spell`: enable spell check?
    * `]s`: go to next misspelled word
    * `[s`: go to last misspelled word
    * `z=`: get suggestions for a misspelled word (when over it)
    * `zg`: mark a misspelled word as correct
    * `zw`: mark a good word as misspelled
    * `^N`: *next* auto-complete in insert mode only (`set complete+=kspell`)
    * `^P`: *previous* auto-complete in insert mode only (`set complete+=kspell`)
* Substitution
    * `:%s /foo/bar/g`: *substitute* all foo with bar on every line
    * `:s /foo/bar/g`: *substitute* all foo with bar only on current line
    * `:%s/^/this/g`: insert 'this' at the beginning of every line
    * `:%s/$/this/g`: insert 'this' at the end of every line
    * `:1,^s/foo/bar/g`: replace all 'foo' with 'bar' from line 1 to
      the start of the current line
    * `g` is for all instances in a file (`:%s`) or a line (`:s`) (*global*)
    * `c` is for *confirmation*
* Text objects (perform actions/verbs against complex targets/nouns)
    * `iw`: *inside word* (doesn't get spaces)
    * `aw`: *around word* (gets spaces around)
        * `daw`: *delete around word*
    * `is` & `as`: sentences
        * `cis`: *change inside sentence* (delete entire sentence and get in
          Insert Mode)
    * `ip` & `ap`: paragraphs
    * `i'` & `a'`: single quotes
    * `i"` & `a"`: double quotes
        * `ci"`: *change* everything *inside* double quotes
          (change only thing in quotes)
        * `ca"`: *change* everything *around* double quotes
          (replace full quoted object)
        * edit HTML URL link
            * `ci"`: change link in quotes
            * `cit`: change link tag?
    * `` i` `` & `` a` ``: back ticks
    * `i(` & `a(`: parenthesis
    * `i[` & `a[`: brackets
    * `i{` & `a{`: braces
    * `it` & `at`: tags
* Visual mode
    * `v`: char-based
    * `V`: line-based
    * `^V`: paragraphs

## Plugins/bundles

* `:SyntasticInfo`: check *syntastic* status
* `:BundleList`: list of bundles
* `:BundleInstall!`: force update of bundles

## Tabs and spaces

* Replace spaces with tabs
    * `:retab!`
    * `:%s/^\([^I]*\)    /\1^I/g`: bad?
* Replace tabs with spaces
    * `:retab`
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

## Comments

* Comment N lines using visual block mode [Best]
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

* `:.,+N-1 s/^/#/g`: comment N lines
* `:%s/^/#/g`: comment every line in a file
* `:5,10s/^/#`: comment lines 5 through 10

## Misc

* `:set nu`: show line numbers
