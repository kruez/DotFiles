ZSH_THEME="powerlevel10k/powerlevel10k"
source $CUSTOM_ZSH_THEMES/powerlevel10k-config.sh

# These customizations must be set after sourcing the above config file!

typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=38
typeset -g POWERLEVEL9K_DIR_FOREGROUND=31
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=31

typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=172

# Green prompt symbol if the last command succeeded.
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=148

# Red prompt symbol if the last command failed.
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=203

typeset -g POWERLEVEL9K_STATUS_ERROR=true

# NOTE: Some Git color customizations are occurring within the my_git_formatter function
# in the config file.
# clean => 112
