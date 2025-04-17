# Git Cheatsheet

## Basic Commands

- `git status`                → Show working tree status
- `git add <file>`            → Stage changes
- `git commit -m "message"`   → Commit staged changes
- `git checkout -b <branch>`  → Create & switch to a new branch
- `git checkout <branch>`     → Switch branches

## Branch Management

- `git branch`                → List local branches
- `git branch -r`             → List remote branches
- `git branch -D <branch>`    → Delete a branch

## Updating & Rebasing

- `git pull --rebase`         → Fetch & rebase onto current branch
- `git rebase -i <base>`      → Interactive rebase against `<base>`

## Merging & Pull Requests

- `git merge <branch>`        → Merge `<branch>` into current branch
- `git push origin <branch>`  → Push commits to remote