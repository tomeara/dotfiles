mv ~/.zprofile ~/.zprofile-old
cp -fRv ./.zprofile ~/.zprofile
mv ~/.tmux.conf ~/.tmux.old
cp -fRv ./.tmux.conf ~/.tmux.conf
cp -fRv ./itg-text.zsh-theme ~/.oh-my-zsh/themes/itg-text.zsh-theme
cp -fv ./.gitmessage ~/.gitmessage

# Shared agent instructions (~/.agents)
mkdir -p ~/.agents
cp -fv ./agents/AGENTS.md ~/.agents/AGENTS.md

# Neovim
mkdir -p ~/.config/nvim
cp -fv ./nvim/init.vim ~/.config/nvim/init.vim

# VS Code
mkdir -p ~/Library/Application\ Support/Code/User/snippets
cp -fv ./vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
cp -fv ./vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
rsync -av ./vscode/snippets/ ~/Library/Application\ Support/Code/User/snippets/
xargs -n1 code --install-extension < ./vscode/extensions.txt
