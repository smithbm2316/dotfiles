#! /usr/bin/env fish

echo 'Enter the branch name you want to review the PR for: '
read prBranch

if test "$prBranch" = "c"
  echo 'Cancelling, bye!'
  return
end

if not test -n "$prBranch"
  echo 'Using current branch'
  set -l defaultBranch (awk -F "/" '{print $NF}' .git/refs/remotes/origin/HEAD)
  set -l headCommitHash (git log -n 1 --pretty=format:"%h" $defaultBranch)
  set -l repoDir (pwd)
  tmux display-popup -xR -yC -w '70%' -h '100%' -E -d $repoDir git diff $headCommitHash..HEAD 
else
  set -l defaultBranch (awk -F "/" '{print $NF}' .git/refs/remotes/origin/HEAD)
  git switch $defaultBranch
  git fetch
  set -l headCommitHash (git log -n 1 --pretty=format:"%h" $defaultBranch)
  git checkout $prBranch
  set -l repoDir (pwd)
  tmux display-popup -xR -yC -w '70%' -h '100%' -E -d $repoDir git diff $headCommitHash..HEAD
end
