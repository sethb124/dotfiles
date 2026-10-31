function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end

if status is-interactive
    set fish_greeting
    set -gx BROWSER zen-browser
    set -gx EDITOR nvim
    set fish_key_bindings fish_user_key_bindings
    set PATH "$HOME/.ghcup/bin" $PATH
    set PATH "$HOME/.cabal/bin" $PATH
end
starship init fish | source
zoxide init fish --cmd cd | source

# Created by `pipx` on 2025-02-17 18:46:14
set PATH $PATH /home/seth/.local/bin


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/seth/.opam/opam-init/init.fish' && source '/home/seth/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

alias r "R_AUTO_START=true nvim"
