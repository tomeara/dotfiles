cp -fvr ~/.zprofile ./.zprofile
cp -fvr ~/.tmux.conf ./.tmux.conf
cp -fvr ~/.oh-my-zsh/themes/itg-text.zsh-theme ./itg-text.zsh-theme

# VS Code — settings, keybindings, snippets, extension list; mcp.json excluded (contains tokens)
mkdir -p ./vscode
cp -fv ~/Library/Application\ Support/Code/User/settings.json ./vscode/settings.json
cp -fv ~/Library/Application\ Support/Code/User/keybindings.json ./vscode/keybindings.json
rsync -av --delete ~/Library/Application\ Support/Code/User/snippets/ ./vscode/snippets/
code --list-extensions > ./vscode/extensions.txt
