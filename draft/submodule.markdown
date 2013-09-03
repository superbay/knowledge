```ruby
# Workflow from https://github.com/necolas/dotfiles
 
# Add the new submodule
git submodule add git://example.com/remote/path/to/repo.git vim/bundle/one-submodule
# Initialize the submodule
git submodule init
# Clone the submodule
git submodule update
# Stage the changes
git add vim/bundle/one-submodule
# Commit the changes
git commit -m "Add a new submodule: one-submodule"
 
# Update an individual submodule within the superproject
# Change to the submodule directory
cd vim/bundle/one-submodule
# Checkout the desired branch (of the submodule)
git checkout master
# Pull from the tip of master (of the submodule - could be any sha or pointer)
git pull origin master
# Go back to main dotfiles repo root
cd ../../..
# Stage the submodule changes
git add vim/bundle/one-submodule
# Commit the submodule changes
git commit -m "Update submodule 'one-submodule' to the latest version"
# Push to a remote repository
git push origin master
 
# When updating a local repository from the remote repository I use
# `git submodule update` to update the submodules (that have been 
# initialized) in their local repository. This wipes any local 
# changes made to the submodule.
```
