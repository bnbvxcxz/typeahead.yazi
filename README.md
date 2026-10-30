# typeahead.yazi

KDE Dolphin style typeahead file nav for Yazi.

I prefer to navigate my file manager using typeahead where all my binds are on
ctrl or alt. And it was fun lua practice.

Instead of having a filter bind, you can just type the string of the directory
or file and the cursor will navigate to it directly. Hitting `Enter` while still
in the timeout period lets you jump between the files that matched your input,
or immediately opens the target if only one match exists.

## Installation

Install using Yazi's package manager:

```bash
ya pkg add nottucks/typeahead
```

Or clone manually into your plugins directory:

```bash
git clone [https://github.com/nottucks/typeahead.yazi.git](https://github.com/nottucks/typeahead.yazi.git) ~/.config/yazi/plugins/typeahead.yazi
```

## Configuration

1. **Place in `init.lua`**

Add the plugin setup to `~/.config/yazi/init.lua` and pass the configuration
parameters according to your wants:

```lua
require("typeahead"):setup({
    timeout = 1.5,
    case_sensitive = false,
    max_length = 24,
})
```

- **timeout**: Takes a number (in seconds) before the search buffer decays.
- **case_sensitive**: Takes a boolean (`true` or `false`).
- **max_length**: Takes an integer for the max buffer display length.

2. **Add keybinds in `keymap.toml`**

Add the following to `~/.config/yazi/keymap.toml` under `prepend_keymap`:

```toml
[mgr]

prepend_keymap = [
    # Core Navigation (Typeahead Intercepts)
    { on = [ "<Enter>" ], run = "plugin typeahead -- enter",  desc = "Cycle typeahead match or smart-enter" },
    { on = [ "<Right>" ], run = "plugin typeahead -- right",  desc = "Enter dir / open file and clear typeahead" },
    { on = [ "<Esc>" ],   run = "plugin typeahead -- escape", desc = "Clear typeahead buffer and cancel state" },

    # Typeahead: Lowercase a-z
    { on = [ "a" ], run = "plugin typeahead -- a", desc = "Typeahead: a" },
    { on = [ "b" ], run = "plugin typeahead -- b", desc = "Typeahead: b" },
    { on = [ "c" ], run = "plugin typeahead -- c", desc = "Typeahead: c" },
    { on = [ "d" ], run = "plugin typeahead -- d", desc = "Typeahead: d" },
    { on = [ "e" ], run = "plugin typeahead -- e", desc = "Typeahead: e" },
    { on = [ "f" ], run = "plugin typeahead -- f", desc = "Typeahead: f" },
    { on = [ "g" ], run = "plugin typeahead -- g", desc = "Typeahead: g" },
    { on = [ "h" ], run = "plugin typeahead -- h", desc = "Typeahead: h" },
    { on = [ "i" ], run = "plugin typeahead -- i", desc = "Typeahead: i" },
    { on = [ "j" ], run = "plugin typeahead -- j", desc = "Typeahead: j" },
    { on = [ "k" ], run = "plugin typeahead -- k", desc = "Typeahead: k" },
    { on = [ "l" ], run = "plugin typeahead -- l", desc = "Typeahead: l" },
    { on = [ "m" ], run = "plugin typeahead -- m", desc = "Typeahead: m" },
    { on = [ "n" ], run = "plugin typeahead -- n", desc = "Typeahead: n" },
    { on = [ "o" ], run = "plugin typeahead -- o", desc = "Typeahead: o" },
    { on = [ "p" ], run = "plugin typeahead -- p", desc = "Typeahead: p" },
    { on = [ "q" ], run = "plugin typeahead -- q", desc = "Typeahead: q" },
    { on = [ "r" ], run = "plugin typeahead -- r", desc = "Typeahead: r" },
    { on = [ "s" ], run = "plugin typeahead -- s", desc = "Typeahead: s" },
    { on = [ "t" ], run = "plugin typeahead -- t", desc = "Typeahead: t" },
    { on = [ "u" ], run = "plugin typeahead -- u", desc = "Typeahead: u" },
    { on = [ "v" ], run = "plugin typeahead -- v", desc = "Typeahead: v" },
    { on = [ "w" ], run = "plugin typeahead -- w", desc = "Typeahead: w" },
    { on = [ "x" ], run = "plugin typeahead -- x", desc = "Typeahead: x" },
    { on = [ "y" ], run = "plugin typeahead -- y", desc = "Typeahead: y" },
    { on = [ "z" ], run = "plugin typeahead -- z", desc = "Typeahead: z" },

    # Typeahead: Uppercase A-Z
    { on = [ "A" ], run = "plugin typeahead -- A", desc = "Typeahead: A" },
    { on = [ "B" ], run = "plugin typeahead -- B", desc = "Typeahead: B" },
    { on = [ "C" ], run = "plugin typeahead -- C", desc = "Typeahead: C" },
    { on = [ "D" ], run = "plugin typeahead -- D", desc = "Typeahead: D" },
    { on = [ "E" ], run = "plugin typeahead -- E", desc = "Typeahead: E" },
    { on = [ "F" ], run = "plugin typeahead -- F", desc = "Typeahead: F" },
    { on = [ "G" ], run = "plugin typeahead -- G", desc = "Typeahead: G" },
    { on = [ "H" ], run = "plugin typeahead -- H", desc = "Typeahead: H" },
    { on = [ "I" ], run = "plugin typeahead -- I", desc = "Typeahead: I" },
    { on = [ "J" ], run = "plugin typeahead -- J", desc = "Typeahead: J" },
    { on = [ "K" ], run = "plugin typeahead -- K", desc = "Typeahead: K" },
    { on = [ "L" ], run = "plugin typeahead -- L", desc = "Typeahead: L" },
    { on = [ "M" ], run = "plugin typeahead -- M", desc = "Typeahead: M" },
    { on = [ "N" ], run = "plugin typeahead -- N", desc = "Typeahead: N" },
    { on = [ "O" ], run = "plugin typeahead -- O", desc = "Typeahead: O" },
    { on = [ "P" ], run = "plugin typeahead -- P", desc = "Typeahead: P" },
    { on = [ "Q" ], run = "plugin typeahead -- Q", desc = "Typeahead: Q" },
    { on = [ "R" ], run = "plugin typeahead -- R", desc = "Typeahead: R" },
    { on = [ "S" ], run = "plugin typeahead -- S", desc = "Typeahead: S" },
    { on = [ "T" ], run = "plugin typeahead -- T", desc = "Typeahead: T" },
    { on = [ "U" ], run = "plugin typeahead -- U", desc = "Typeahead: U" },
    { on = [ "V" ], run = "plugin typeahead -- V", desc = "Typeahead: V" },
    { on = [ "W" ], run = "plugin typeahead -- W", desc = "Typeahead: W" },
    { on = [ "X" ], run = "plugin typeahead -- X", desc = "Typeahead: X" },
    { on = [ "Y" ], run = "plugin typeahead -- Y", desc = "Typeahead: Y" },
    { on = [ "Z" ], run = "plugin typeahead -- Z", desc = "Typeahead: Z" },

    # Typeahead: Digits 0-9
    { on = [ "0" ], run = "plugin typeahead -- 0", desc = "Typeahead: 0" },
    { on = [ "1" ], run = "plugin typeahead -- 1", desc = "Typeahead: 1" },
    { on = [ "2" ], run = "plugin typeahead -- 2", desc = "Typeahead: 2" },
    { on = [ "3" ], run = "plugin typeahead -- 3", desc = "Typeahead: 3" },
    { on = [ "4" ], run = "plugin typeahead -- 4", desc = "Typeahead: 4" },
    { on = [ "5" ], run = "plugin typeahead -- 5", desc = "Typeahead: 5" },
    { on = [ "6" ], run = "plugin typeahead -- 6", desc = "Typeahead: 6" },
    { on = [ "7" ], run = "plugin typeahead -- 7", desc = "Typeahead: 7" },
    { on = [ "8" ], run = "plugin typeahead -- 8", desc = "Typeahead: 8" },
    { on = [ "9" ], run = "plugin typeahead -- 9", desc = "Typeahead: 9" },

    # Typeahead: Symbols & Punctuation
    { on = [ "." ], run = "plugin typeahead -- .", desc = "Typeahead: ." },
    { on = [ "_" ], run = "plugin typeahead -- _", desc = "Typeahead: _" },
    { on = [ "-" ], run = "plugin typeahead -- -", desc = "Typeahead: -" },
    { on = [ "~" ], run = "plugin typeahead -- ~", desc = "Typeahead: ~" },
    { on = [ "@" ], run = "plugin typeahead -- @", desc = "Typeahead: @" },
    { on = [ "#" ], run = "plugin typeahead -- #", desc = "Typeahead: #" },
    { on = [ "$" ], run = "plugin typeahead -- $", desc = "Typeahead: $" },
    { on = [ "%" ], run = "plugin typeahead -- %", desc = "Typeahead: %" },
    { on = [ "^" ], run = "plugin typeahead -- ^", desc = "Typeahead: ^" },
    { on = [ "&" ], run = "plugin typeahead -- &", desc = "Typeahead: &" },
    { on = [ "(" ], run = "plugin typeahead -- (", desc = "Typeahead: (" },
    { on = [ ")" ], run = "plugin typeahead -- )", desc = "Typeahead: )" },
    { on = [ "[" ], run = "plugin typeahead -- [", desc = "Typeahead: [" },
    { on = [ "]" ], run = "plugin typeahead -- ]", desc = "Typeahead: ]" },
    { on = [ "{" ], run = "plugin typeahead -- {", desc = "Typeahead: {" },
    { on = [ "}" ], run = "plugin typeahead -- }", desc = "Typeahead: }" },
    { on = [ "!" ], run = "plugin typeahead -- !", desc = "Typeahead: !" },
    { on = [ "=" ], run = "plugin typeahead -- =", desc = "Typeahead: =" },
]
```

## Acknowledgments

- Enter/open fallback logic adapted from
  [smart-enter.yazi](https://github.com/Ape/smart-enter.yazi) by Ape (MIT
  License).

## License

MIT
