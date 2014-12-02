# to merge a file (outside any branch because its branch was deleted) to the master branch
git checkout master
git merge <hash of commit>

# amend an older commit
$ git rebase --interactive bbc643cd^
# In the default editor, modify 'pick' to 'edit' in the line whose commit you want
# to modify. Make your changes and then stage them with
$ git add <filepattern>
$ git commit --amend
$ git rebase --continue

# rename remote URL
git remote set-url origin https://github.com/vgslavov/MS-thesis.git

# replace
# local changes (with last content in HEAD)
git checkout -- file.txt
# - drop all local changes and commits
# - fetch latest history from server
# - point local master branch at it
git fetch origin
git reset --hard origin/master

# remove a file from the staging area
git reset <filename>

# unstage
git reset HEAD <filename>

##############################
# DON'T DO THESE AFTER PUSH! #

# reset into staging and move to commit before HEAD
# (undo last commit, put changes into staging)
git reset --soft HEAD^

# amend commit message only
# (change the last commit)
git commit --amend -m "New commit message"

# undo last commit and all changes
git reset --hard HEAD^

# undo last 2 commits and all changes
git reset --hard HEAD^^

##############################

# don't forget the quotes (to prevent the shell from expanding *)
git add "*.txt"
# interactive adding
git add -i

# add all (even in parent dirs)
git add --all

# create branch
git branch cat

# see branches
git branch

# switch to a branch
git checkout cat

# merge to mmaster
git checkout master
git merge cat

# delete branch when done
git branch -d cat

# create a new repository on the command line
touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/vgslavov/try_git.git
# show remote repositories
git remote -v
# push local branch 'master' to remote repository 'origin'
git push -u origin master

# push an existing repository from the command line
git remote add origin https://github.com/vgslavov/try_git.git
git push -u origin master

# -u: remember parameters (name of origin repository)
git push -u origin master

# don't commit, stash instead (if not sure)
git stash
# re-apply after pull
git stash apply

# what's different from last commit (after pull)
git diff HEAD

# keep related changes in separate commits:
# use 'get diff' before starting to 'add'

# see only staged changes
git diff --staged

# unstage files
git reset file.txt

# get rid of all changes since last commit ('--' tells git no more options after)
git checkout -- file.txt

# auto remove deleted files (which were not deleted using 'git rm')
git commit -am "Delete stuff"

# can't delete (-d) a branch which has not been merged, so use -D (-d -f)
git branch -D bad_feature

# log
# see log+diff
git log --oneline --patch
git log --oneline --stat
git log --since=2012-01-01 --until=2012-12-21

# diff
# b/w last commit and current state (both staged and unstaged)
git diff HEAD
# parent of latest commit
git diff HEAD^
# grandparent
git diff HEAD^^
# specific file
git show HEAD^^:lib/tasks/sample_data.rake
# five commits ago
git diff HEAD~5
# second most recent vs. most recent
git diff HEAD^..HEAD
# b/w branches
git diff master mybranch

# who did what when
git blame index.html --date short

# untracking files (don't delete from local file system)
git rm --cached development.log

git log c5271 myfile
git checkout c5271 myfile

git branch -b int2POLY
git branch
...
git add .
git commit
git checkout master
git merge int2POLY
git push
