function noctalia-palette --description 'Show the active Noctalia wallpaper palette as color swatches'
    # Usage: noctalia-palette [scheme] [--light]
    set -l current (noctalia msg color-scheme-get | string split ' ')
    if test "$current[1]" != wallpaper; and test (count $argv) -eq 0
        echo "Active source is '$current[1] $current[2]', not a wallpaper scheme; pass a scheme name to preview one."
        return 1
    end

    set -l scheme $current[2]
    set -l mode --dark
    for arg in $argv
        switch $arg
            case --light
                set mode --light
            case '*'
                set scheme $arg
        end
    end

    set -l img (noctalia msg wallpaper-get)
    echo "wallpaper: $img"
    echo "scheme:    $scheme ($mode)"
    echo

    noctalia theme "$img" --scheme $scheme $mode 2>/dev/null | python3 -c '
import json, sys
d = json.load(sys.stdin)
def rgb(h):
    h = h.lstrip("#")
    return int(h[0:2], 16), int(h[2:4], 16), int(h[4:6], 16)
for key, val in d.items():
    if not (isinstance(val, str) and val.startswith("#")):
        continue
    r, g, b = rgb(val)
    fg = "0;0;0" if (0.299 * r + 0.587 * g + 0.114 * b) > 140 else "255;255;255"
    print(f"\x1b[48;2;{r};{g};{b}m\x1b[38;2;{fg}m {val} \x1b[0m  {key}")
'
end
