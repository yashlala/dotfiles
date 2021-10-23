neovim_autocd() {
    [[ $NVIM_LISTEN_ADDRESS ]] && ~/.local/scripts/neovim-autocd
}
precmd_functions+=( neovim_autocd )
