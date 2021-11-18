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

# configure neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim --headless +PlugInstall +q

# configure tmux - swiped from here: https://github.com/tmux-plugins/tpm/issues/6#issuecomment-54520698
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
tmux kill-server

# configure zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
