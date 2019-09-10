# source and configure zsh syntax highlighting.

if [ -r '/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
  # set active highlighters
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

  typeset -A ZSH_HIGHLIGHT_STYLES

  # set 'main' highlighter options
  ZSH_HIGHLIGHT_STYLES[default]='none'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
  ZSH_HIGHLIGHT_STYLES[alias]='none'
  ZSH_HIGHLIGHT_STYLES[builtin]='none'
  ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[command]='none'
  ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[path]='none'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=green'
  ZSH_HIGHLIGHT_STYLES[arg0]='none'

  ZSH_HIGHLIGHT_STYLES[assign]='none'
  ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[redirection]='fg=yellow'

  # ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=green'
  # ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=green'
  # ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=green'
  # ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=black,bold'
  # ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=black,bold'

  # ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=black,bold'

  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'

  # set 'brackets' highlighter options
  ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
  ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='none'

  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
