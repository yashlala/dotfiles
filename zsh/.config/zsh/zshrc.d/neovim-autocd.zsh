if [[ $NVIM_LISTEN_ADDRESS ]]; then
    neovim_autocd() {
        ~/.local/scripts/neovim-autocd
    }
    precmd_functions+=( neovim_autocd )
fi
