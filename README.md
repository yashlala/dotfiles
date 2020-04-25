My Arch Linux dotfiles.

Please feel free to copy anything you like.

# Branches

The 'global' branch includes changes that are broadly applicable to all of my
Linux installations. All other branches are associated with a particular
machine ('graphite', for example, deals with my laptop). The contents of the
branches should be more-or-less in sync, aside from machine-specific changes
such as font size tweaks. 

# Installation

These config files are managed via GNU Stow. If you'd like to use them, clone
this repository into a folder under your home directory (such as
`~/.dotfiles`), then run `stow` on each desired subfolder (eg. `stow zsh`).
Consult the GNU Stow manual for more details. 
