help: all

all:
	@echo ""
	@echo "---------------------------------------------------------------------------"
	@echo " 💡 INSTALLERS-A-LA-CARTE 🚀"
	@echo "---------------------------------------------------------------------------"
	@echo ""
	@echo " make install_everything     # install everything"
	@echo " make install_neovim         # install neovim"
	@echo " make install_lsp_servers    # install LSP servers"
	@echo " make install_tools          # install some of the tools I use :-)"
	@echo " make install_fonts          # install fonts"
	@echo " make install_fzf            # install fzf"
	@echo " make install_dbeaver        # install dbeaver community edition"
	@echo " make install_tmux           # install tmux"
	@echo " make install_node           # install Node.js"
	@echo " make install_rbenv          # install rbenv"
	@echo " make install_ohmyzsh        # install oh-my-zsh"
	@echo " make install_alacritty      # install alacritty"
	@echo " make install_kitty          # install kitty"
	@echo " make install_rectangle      # install rectangle"
	@echo " make install_watchman       # install watchman"
	@echo ""

install_everything: install_neovim install_tools install_fonts install_tmux install_node install_rbenv install_ohmyzsh install_alacritty install_rectangle install_fzf install_watchman install_dbeaver install_kitty
	@echo "[FINISHED] Everything installed 😀"

install_neovim: install_node install_lsp_servers install_fzf
	@echo "[REMOVING] Old neovim packages"
	@rm -rf .cache/nvim
	@rm -rf .local/share/nvim/
	@echo "[INSTALLING] nvim bat" # https://github.com/sharkdp/bat
	@brew install nvim bat
	@echo "[INSTALLING] nvim ripgrep"
	@brew install nvim ripgrep
	@echo "[INSTALLING] packer"
	@rm -rf ~/.local/share/nvim/site/pack/packer/
	@git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	@echo "[CONFIGURING] neovim"
	@mkdir -p ${HOME}/.config
	@rm -f ${HOME}/.config/nvim
	@ln -s ${HOME}/github/profile/nvim/ ${HOME}/.config/nvim

install_lsp_servers:
	@echo "[LSP] Installing LSP servers"
	@echo "  - clangd [part of llvm package]"
	@brew install llvm
	@echo "  - docker language server [Dockerfile LSP]"
	@brew install dockerfile-language-server
	@echo "  - gopls [Go LSP]"
	@brew install gopls
	@echo "  - pyright [Python LSP]"
	@brew install pyright
	@echo "  - ruby-lsp [Ruby LSP]"
	@brew install ruby-lsp
	@echo "  - sql-language-server [SQL LSP]"
	@brew install sql-language-server
	@echo "  - rust-analyzer [Rust LSP]"
	@brew install rust-analyzer
	@echo "  - texlab [LaTeX LSP]"
	@brew install texlab
	@echo "  - typescript-language-server [TypeScript LSP]"
	@brew install typescript-language-server

install_tools:
	@echo "[INSTALLING] Tools"
	@brew install htop lazygit lazydocker the_silver_searcher wget neovide git-delta bat
	@rm -f ${HOME}/.gitconfig && ln -s $(PWD)/git/.gitconfig ${HOME}/.gitconfig

install_fonts:
	# FiraCode
	@cp fonts/FiraCode.zip ~/Library/Fonts/
	@cd ~/Library/Fonts/; yes A | unzip ~/Library/Fonts/FiraCode.zip; cd -
	@rm -f ~/Library/Fonts/FiraCode.zip

	# Cascadia
	@cp fonts/CascadiaCode.zip ~/Library/Fonts/
	@cd ~/Library/Fonts/; yes A | unzip ~/Library/Fonts/CascadiaCode.zip; cd -
	@rm -f ~/Library/Fonts/CascadiaCode.zip

	# Victor Mono Font [this includes handwriting ligatures]
	@cp fonts/VictorMono.zip ~/Library/Fonts/
	@cd ~/Library/Fonts/; yes A | unzip ~/Library/Fonts/VictorMono.zip; cd -
	@rm -f ~/Library/Fonts/VictorMono.zip

install_tmux:
	@echo "[INSTALLING] tmux"
	@brew install tmux
	@rm -f ~/.tmux.conf
	@ln -s "$(shell pwd)/tmux/.tmux.conf" ~/.tmux.conf

install_fzf:
	@echo "[INSTALLING] fzf"
	@brew install fzf

# This is a tool to move windows around
install_rectangle:
	@echo "[INSTALLING] rectangle [change window sizes with keystrokes]"
	@brew install rectangle

install_node:
	@echo "[INSTALLING] Node.js"
	@brew install node

install_rbenv:
	@echo "[INSTALLING] rbenv"
	@brew install rbenv
	@echo "rbenv init"
	@echo "^^^^^^^^^^ RUN THIS AND FOLLOW INSTRUCTIONS"
	@echo "Also take a look at this: https://thoughtbot.com/blog/using-rbenv-to-manage-rubies-and-gems"

install_ohmyzsh:
	@echo "[INSTALLING] oh-my-zsh"
	@sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install_watchman: # This is required by sorbet
	@echo "[INSTALLING] watchman"
	@brew install watchman

install_dbeaver:
	@echo "[INSTALLING] DBeaver community edition"
	@brew install dbeaver-community

install_alacritty:
	@echo "[INSTALLING] alacritty"
	@brew install alacritty
	@echo "[CONFIGURING] neovim"
	@rm -f ~/.config/alacritty/
	@ln -s ${HOME}/github/profile/alacritty/ ${HOME}/.config/alacritty

install_kitty:
	@echo "[INSTALLING] kitty"
	@brew install kitty
	@echo "[CONFIGURING] kitty"
	@rm -f ~/.config/kitty/
	@ln -s ${HOME}/github/profile/kitty/ ${HOME}/.config/kitty
