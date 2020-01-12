# Functions
source ~/.shell/functions.sh

if [ ! -f ~/.df/aliases_customized.sh ]; then
    touch ~/.df/aliases_customized.sh
    chmod +x ~/.df/aliases_customized.sh
fi

if [ -f ~/.gitconfig_local ]; then
    mv ~/.gitconfig_local ~/.df/gitconfig_customized
else
    if [ ! -f ~/.df/gitconfig_customized ]; then
        touch ~/.df/gitconfig_customized
    fi
fi

if [ -f ~/.gvimrc_customized ]; then
    mv ~/.gvimrc_customized ~/.df/gvimrc_customized
else
    if [ ! -f ~/.df/gvimrc_customized ]; then
        touch ~/.df/gvimrc_customized
    fi
fi

if [ -f ~/.vimrc_customized ]; then
    mv ~/.vimrc_customized ~/.df/vimrc_customized
else
    if [ ! -f ~/.df/vimrc_customized ]; then
        touch ~/.df/vimrc_customized
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
source ~/.df/aliases_customized.sh

# Custom prompt
source ~/.zsh/prompt.zsh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
