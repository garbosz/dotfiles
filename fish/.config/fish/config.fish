test -f /usr/share/cachyos-fish-config/cachyos-config.fish; and
source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Hermes Agent command
fish_add_path "$HOME/.local/bin"
