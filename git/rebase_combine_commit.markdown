### using rebase to combine serveral commit

use `rebase -i master`

```ruby

pick b76d157 b
pick a931ac7 c

# Rebase df23917..a931ac7 onto df23917
#
# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#


```

just modify the pick into s, then that commit will be combine to the pick
