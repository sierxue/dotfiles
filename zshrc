# Functions
source ~/.shell/functions.sh

if [ ! -d ~/.df/dotfiles-vm-u18 ]; then
    mkdir ~/.df/dotfiles-vm-u18
fi

if [ -f ~/.df/aliases_customized.sh ]; then
    mv ~/.df/aliases_customized.sh ~/.df/dotfiles-vm-u18/aliases_customized.sh
else
    if [ ! -f ~/.df/dotfiles-vm-u18/aliases_customized.sh ]; then
        touch ~/.df/dotfiles-vm-u18/aliases_customized.sh
        chmod +x ~/.df/dotfiles-vm-u18/aliases_customized.sh
    fi
fi

if [ -f ~/.gitconfig_local ]; then
    mv ~/.gitconfig_local ~/.df/dotfiles-vm-u18/gitconfig_customized
elif [ -f ~/.df/gitconfig_customized ]; then
        mv ~/.df/gitconfig_customized ~/.df/dotfiles-vm-u18/gitconfig_customized
else
    if [ ! -f ~/.df/dotfiles-vm-u18/gitconfig_customized ]; then
        touch ~/.df/dotfiles-vm-u18/gitconfig_customized
    fi
fi

if [ -f ~/.gvimrc_customized ]; then
    mv ~/.gvimrc_customized ~/.df/dotfiles-vm-u18/gvimrc_customized
elif [ -f ~/.df/gvimrc_customized ]; then
        mv ~/.df/gvimrc_customized ~/.df/dotfiles-vm-u18/gvimrc_customized
else
    if [ ! -f ~/.df/dotfiles-vm-u18/gvimrc_customized ]; then
        touch ~/.df/dotfiles-vm-u18/gvimrc_customized
    fi
fi

if [ -f ~/.vimrc_customized ]; then
    mv ~/.vimrc_customized ~/.df/dotfiles-vm-u18/vimrc_customized
elif [ -f ~/.df/vimrc_customized ]; then
        mv ~/.df/vimrc_customized ~/.df/dotfiles-vm-u18/vimrc_customized
else
    if [ ! -f ~/.df/dotfiles-vm-u18/vimrc_customized ]; then
        touch ~/.df/dotfiles-vm-u18/vimrc_customized
    fi
fi

# Allow local customizations in the ~/.shell_local_before file
if [ -f ~/.shell_local_before ]; then
    source ~/.shell_local_before
fi

# Allow local customizations in the ~/.zshrc_local_before file
if [ -f ~/.zshrc_local_before ]; then
    source ~/.zshrc_local_before
fi

# External plugins (initialized before)
source ~/.zsh/plugins_before.zsh

# Settings
source ~/.zsh/settings.zsh

# Bootstrap
source ~/.shell/bootstrap.sh

# External settings
source ~/.shell/external.sh

# Aliases
source ~/.shell/aliases.sh
source ~/.shell/aliases_local.sh
source ~/.df/dotfiles-vm-u18/aliases_customized.sh

# Custom prompt
# source ~/.zsh/prompt.zsh

# External plugins (initialized after)
source ~/.zsh/plugins_after.zsh

# Allow local customizations in the ~/.shell_local_after file
if [ -f ~/.shell_local_after ]; then
    source ~/.shell_local_after
fi

# Allow local customizations in the ~/.zshrc_local_after file
if [ -f ~/.zshrc_local_after ]; then
    source ~/.zshrc_local_after
fi

if [ -f ~/.df/dotfiles-local/zshrc_local ]; then
    source ~/.df/dotfiles-local/zshrc_local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
