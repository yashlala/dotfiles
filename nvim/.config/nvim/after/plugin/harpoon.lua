require('harpoon').setup {
  global_settings = {
    -- Sets the marks when calling `toggle` on the UI. Doesn't require `:w`.
    save_on_toggle = false,

    -- Saves the harpoon file upon every change. Disabling is not recommended.
    save_on_change = true,

    -- Sets harpoon to run the command immediately as it's passed to the
    -- terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- Closes any tmux windows that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" }

  }
}
