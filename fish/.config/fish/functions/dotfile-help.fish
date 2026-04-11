function dotfile-help --description "Show a quick reference for all dotfile features"
    set -l bold (set_color --bold normal)
    set -l dim (set_color brblack)
    set -l rst (set_color normal)
    set -l grn (set_color green)
    set -l cyn (set_color cyan)
    set -l yel (set_color yellow)
    set -l mag (set_color magenta)
    set -l blu (set_color blue)

    function _section --no-scope-shadowing
        echo
        echo "$yel$bold$argv[1]$rst"
        echo "$dim"(string repeat -n (string length $argv[1]) ─)"$rst"
    end

    function _row --no-scope-shadowing
        printf "  $cyn%-22s$rst %s\n" $argv[1] $argv[2]
    end

    echo
    echo "$bold  DOTFILE QUICK REFERENCE$rst"
    echo "$dim  "(string repeat -n 40 ─)"$rst"

    _section "PROMPT"
    _row "hydro" "path $dim❱$rst branch$grn •$rst $blu↑$rst$mag↓$rst  (duration on slow cmds)"

    _section "NAVIGATION"
    _row "z <query>"    "zoxide: jump to frecent dir"
    _row "z -"          "go to previous directory"
    _row "zi <query>"   "interactive zoxide + fzf picker"

    _section "FZF KEY BINDINGS"
    _row "Ctrl+R"       "search shell history (atuin)"
    _row "Ctrl+Alt+F"   "fuzzy file / directory search"
    _row "Ctrl+Alt+L"   "fuzzy git log search"
    _row "Ctrl+Alt+S"   "fuzzy git status (stage / diff)"
    _row "Ctrl+Alt+P"   "fuzzy running process search"
    _row "Ctrl+V"       "fuzzy shell variable search"

    _section "ALIASES"
    _row "l / ll / lla" "eza  (ls, ls -l, ls -la)"
    _row "cat"          "bat  (syntax-highlighted pager)"
    _row "lg"           "lazygit  — full TUI git client"
    _row "gi"           "gitui    — alternate TUI git client"

    _section "GIT ALIASES  (git <alias>)"
    _row "st"           "short status with branch"
    _row "co"           "checkout"
    _row "br"           "branches with upstream tracking info"
    _row "lg"           "pretty graph log of all branches"
    _row "last"         "last commit + changed files"
    _row "unstage"      "restore --staged <file>"
    _row "aliases"      "list every git alias"

    _section "GIT DIFF  (delta pager)"
    _row "side-by-side" "enabled by default"
    _row "n / N"        "jump between diff sections"
    _row "line numbers" "shown in all diffs"

    _section "NODE  (fnm)"
    _row "fnm install --lts"   "install latest LTS  (auto-runs if no node)"
    _row "fnm use <ver>"       "switch version in current shell"
    _row "fnm default <ver>"   "set global default"
    _row ".node-version"       "auto-switched on cd (use-on-cd)"

    _section "PYTHON  (uv)"
    _row "uv pip install ..."  "fast pip replacement"
    _row "uv venv"             "create a virtual environment"
    _row "uv run <script>"     "run script in isolated env"

    _section "RUST"
    _row "rustup"   "toolchain manager"
    _row "cargo"    "build / run / test"

    _section "DIRENV"
    _row ".envrc"   "auto-loaded on cd into directory"
    _row "direnv allow" "trust a new .envrc"

    _section "EDITOR"
    _row "\$EDITOR"  "nvim"

    echo
    functions --erase _section _row
end
