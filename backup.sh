cp -fvr ~/.zprofile ./.zprofile
cp -fvr ~/.tmux.conf ./.tmux.conf
cp -fvr ~/.oh-my-zsh/themes/itg-text.zsh-theme ./itg-text.zsh-theme
cp -fv ~/.gitmessage ./.gitmessage

# Shared agent instructions (~/.agents)
mkdir -p ./agents
cp -fv ~/.agents/AGENTS.md ./agents/AGENTS.md

# Agent skills — handoff + recall
mkdir -p ./agents/skills
rsync -av --delete --exclude '.DS_Store' ~/.agents/skills/handoff/ ./agents/skills/handoff/
rsync -av --delete --exclude '.DS_Store' ~/.agents/skills/recall/ ./agents/skills/recall/

# Neovim
mkdir -p ./nvim
cp -fv ~/.config/nvim/init.vim ./nvim/init.vim

# VS Code — settings, keybindings, snippets, extension list; mcp.json excluded (contains tokens)
mkdir -p ./vscode
cp -fv ~/Library/Application\ Support/Code/User/settings.json ./vscode/settings.json
cp -fv ~/Library/Application\ Support/Code/User/keybindings.json ./vscode/keybindings.json
rsync -av --delete ~/Library/Application\ Support/Code/User/snippets/ ./vscode/snippets/
code --list-extensions > ./vscode/extensions.txt
