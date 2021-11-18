# dotfiles

My dotfiles, use homegit method to restore, see:
- https://news.ycombinator.com/item?id=11071754
- http://leahneukirchen.org/blog/archive/2013/01/a-grab-bag-of-git-tricks.html
- https://github.com/Siilwyn/my-dotfiles/tree/master/.my-dotfiles
- https://www.atlassian.com/git/tutorials/dotfiles

For setup on new instance:
```
cd ~
# add alias to local bashrc
echo alias mdf='/usr/bin/git --git-dir=$HOME/.my-dotfiles/ --work-tree=$HOME' >> .bashrc

echo .my-dotfiles >> .gitignore
git clone --bare https://github.com/CameronAM/dotfiles.git $HOME/.my-dotfiles
alias mdf='/usr/bin/git --git-dir=$HOME/.my-dotfiles/ --work-tree=$HOME'

# move any files that already exist in the git repo so the checkout does not fail
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

# apply the dotfiles
mdf checkout
mdf config --local status.showUntrackedFiles no
```
