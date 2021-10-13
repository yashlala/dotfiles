neovim_autocd() {
    [[ $NVIM_LISTEN_ADDRESS ]] && ~/.local/scripts/neovim-autocd
}
chpwd_functions+=( neovim_autocd )
