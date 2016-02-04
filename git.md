# Git

## Mastering GitHub course

* git pull
    * git fetch
    * git merge
* git pull --rebase
    * git fetch
    * git rebase
* keeping in sync (on every accepted pull req in upstream repo)
    * add remote for upstream: `git remote add upstream <path_to_repo>`
    * pull changes: `git pull upstream master`
        * fetch changes: `git fetch upstream`
        * merge them into master: `git merge upstream/master master`
    * push them to your remote: `git push origin master`

## Atlassian tutorials

* git add helps to create atomic commits
    * modify a bunch of files
    * stage related changes only
    * commit
    * repeat...
* `~`: relative reference operator
    * `HEAD~3`: great-grandparent of current commit
    * `3157e~1`: commit before 3157e
* `..`: range operator
    * `git log <since>..<until>`: show commit log b/w 2 commits
    * `git log --oneline master..some-feature`: show all commits which are in
      some-feature branch but not in master
* misc
```
# create empty repo w/o working dir (for central repos, not for development)
# dir usually ends in .git
git init --bare <dir>

# stage chunks of a file interactively
git add -p

# add and commit tracked files only
git commit -am "msg"

# show which files were altered
git log --stat

# show patch/diff
git log -p

# filter log
git log --author="<pattern>"
git log --grep="<pattern>"

# specific file only
git log myfile.py
```

### Undoing Changes

* undo
    * unstage: `git reset HEAD <file>`
    * discard changes in work dir: `git checkout -- <file>`
* `git checkout`
    * commits: `git checkout <commit>`
        * makes entire work dir (all files) match commit
        * enters "detached HEAD" state! (HEAD points to a commit now, not a
          branch)
        * read-only operation, doesn't affect current state of project
        * effectively, changes the snapshot you are working on
        * go back to current snapshot: `git checkout master`
    * files: `git checkout <commit> <file>`
        * shows old version of a file
        * adds to staging area
        * not ready-only, affects current state of project
        * can revert to old file version by committing
        * go back to latest version: `git checkout HEAD <file>`
    * branches: `git checkout master`
* `git revert <commit>`
    * *safe*: it doesn't change project history
    * designed to fix *public* commits, it does not rewrite history
    * to "remove" an entire *single* (and *public*) commit anywhere in history
    * it *does not* revert back to a previous state of a project
    * to revert last commit: `git revert HEAD`
* `git reset`
    * **dangerous** and **permanent**, can lose work
    * designed to fix *local* commits and unstaged changes
        * unstaging a file
        * removing a local commit
    * use only to undo *local* changes
    * most often used to undo changes in staging and work dir, not committed
      snapshots
    * can only work backwards from the current commit
    * `git resett <file>`: remove file from staging (but don't overwrite
       changes!)
    * `git reset`: reset the *whole* staging area to match latest commit (but
       don't overwrite work dir changes!) so you can rebuild staged snapshot
    * `git reset --hard`: unstage all and **obliterate** all uncommitted
       changes
    *  `git reset <commit>`: move HEAD to <commit>, reset staging, leave work
        dir alone so you can re-commit with more atomic snapshots
    * `git reset --hard <commit>`: move HEAD to <commit>, reset *both* staging
       area and working dir (**obliterates** all changes after <commit>)
    * `git reset --hard HEAD~2`: remove 2 last commits
    * **never** reset a public commit: don't `git reset <commit>` after `git push`
* `git clean`
    * can be dangerous, **not undoable**
    * remove untracked files from working dir
    * used with `git reset --hard` to return work dir to state of last commit
    * `git clean -n`: dry run (don't remove)
    * `git clean -f`: force is required for removing by default; doesn't work
       for .gitignore files/dirs
    * `git clean -f <path>`: remove only files in <path>
    * `git clean -df`: remove both untracked files and dirs
    * `git clean -xf`: remove untracked files and ignored files

### Rewriting History

* `git commit --amend`
    * combine *staged changes* with last (previous) commit to create a *brand*
      *new* commit
    * *never* amend public commits!
    * don't change last commit msg: `git commit --amend --no-edit`
* `git rebase`
    * move a branch to a new base commit in order to maintain a linear project
      history
    * *common way* to integrate upstream changes into a local repo
    * `git rebase <base>`: where <base> can be
        * ID
        * branch name
        * tag
        * relative ref to HEAD
    * options when master branch has progressed since branch started
        * merge directly: 3-way merge + merge commit
        * rebasing and then merging: fast-forward merge (resulting in linear
          history)
    * *never* rebase public commits!
    * `git rebase -i <base>`: interactive rebasing (alter individual commits)
        * gives complete control over project history
        * use to polish a feature branch before merging in master
* `git reflog`
    * show reflog (history of HEAD changes, branch checkouts, merges, etc.)
    * show reflog with relative dates: `git reflog --relative-date`

### Syncing

* `git remote`
    * `git remote -v`: see all remotes
    * `git remote add <name> <url>`: add remote origin
    * `git remote rm <name>`: remove remote origin
    * `git remote rename <old-name> <new-name>`: rename remote origin
* `git fetch`
    * `git fetch <remote> <branch>`: fetch a remote branch to inspect
       (can checkout locally)
    * to explore origin changes before merging
        * `git fetch origin`: fetch remote's master branch w/o merging
        * `git log --oneline master..origin/master`: see new commits
        * `git checkout master`: go to master branch
        * `git log origin/master`: see log
        * `git merge origin/master`: merge
* `git pull`
    * `git pull <remote>`: fetch and merge
        * `git fetch <remote>`
        * `git merge origin/<current-branch>`
    * `git pull --rebase <remote>`: rebase instead of merge
        * to ensure a linear history (prevents unnecessary merge commits)
    * `git config --global branch.autosetuprebase always`: turn on rebasing
      during a pull
    * move local changes onto pulled ones
        * `git checkout master`
        * `git pull --rebase origin`
* `git push`
    * `git push <remote> <branch>`: push branch
        * creates a local branch in dest repo
        * prevents push if merge in dest repo is non-fast-forward
        * if remote history has diverged, pull remote and then push again
    * `git push <remote> --force`: force push
        * **dangerous** and **destructive**
        * merge in dest repo even if merge is non-fast-forward
        * it will **delete** upstream changes and make remote repo the same as
          local one
        * use case
            * just committed something which nobody else has pulled
            * then did `git commit --amend` or interactive rebase
            * and now `git push --force` to overwrite remote
    * `git push <remote> --all`: push all local branches to remote
    * `git push <remote> --tags`: push tags too
    * only push to bare repos, never push to a normal one
    * example
        * `git checkout master`: be in master branch
        * `git fetch origin master`: fetch w/o merging
        * `git rebase -i origin/master`: clean up/squash commits using
          interactive rebase of local commits on top of pulled ones
          (instead of merging)
        * `git push origin master`

### Using Branches

* `git branch`
    * `git branch`: list all branches
    * `git branch <branch>`: create new branch w/o checking it out
    * `git branch -d <branch>`: delete branch as long as no unmerged changes
    * `git branch -D <branch>`: force delete branch with unmerged changes
    * `git branch -m <branch>`: rename branch
    * a branch is a ref/ptr to a commit
    * the *tip* of a series of commits, not a *container* for commits
* `git checkout`
    * `git checkout <existing-branch>`: check out already created branch
    * `git checkout -b <new-branch>`: check out new branch
    * `git checkout -b <new-branch> <existing-branch>`: base new branch on
      existing instead of current one
    * development should always take place on a branch, *never* on a detached
      HEAD as you can't merge those commits back into trunk
* `git merge`
    * merg *into* the current branch leaving the target branch unaffected
    * `git merge <branch>`: merge specified branch into current branch
    * `git merge --no-ff <branch>`: *always* generatea a merge commit (even on
      fast-forward merges)
    * a fast-forward merge
        * moves the current branch tip up to the target branch tip
        * use for small features and bug fixes
    * a 3-way merge
        * uses 3 commits to generate merge commit (2 branch tips + common
          ancestor)
        * resolving merging conflicts using edit/stage/commit workflow
        * use for longer-running features
        * to prevent 3-way merging (and superfluous merge commits)
            * rebase
            * do a fast-forward merge
    * example
        * `git checkout -b new-feature master`: create and checkout new branch
        * edit/stage/commit
        * `git checkout master`: got back to master
        * `git merge new-feature`: merge new feature branch *into* master
        * `git branch -d new-feature`: delete feature branch

## Commands

```
# Per @jferris: `ff = only` means Git will never implicitly do a merge commit, including while
# doing git pull. If I'm unexpectedly out of sync when I git pull, I get this
# message:
# fatal: Not possible to fast-forward, aborting.
# At that point, I know that I've forgotten to do something in my normal
# workflow, and I retrace my steps.

# to merge a file (outside any branch because its branch was deleted)
# to the master branch
git checkout master
git merge <hash of commit>

# amend an older commit
git rebase --interactive bbc643cd^
# In the default editor, modify 'pick' to 'edit'
# in the line whose commit you want
# to modify. Make your changes and then stage them with
git add <filepattern>
git commit --amend
git rebase --continue

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

# get rid of all changes since last commit
# ('--' tells git no more options after)
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
```
