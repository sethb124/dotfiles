zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

load-env {
  XDG_CACHE_HOME: ($env.HOME | path join .cache)
  XDG_CONFIG_HOME: ($env.HOME | path join .config)
  XDG_DATA_HOME: ($env.HOME | path join .local/share)
  XDG_STATE_HOME: ($env.HOME | path join .local/state)
}

load-env {
  STACK_XDG: '1'
  TEXMFVAR: ($env.XDG_CACHE_HOME | path join texlive/texmf-var)
  CARGO_HOME: ($env.XDG_DATA_HOME | path join cargo)
  NUGET_PACKAGES: ($env.XDG_CACHE_HOME | path join NuGetPackages)
  RUSTUP_HOME: ($env.XDG_DATA_HOME | path join rustup)
  DOTNET_CLI_HOME: ($env.XDG_DATA_HOME | path join dotnet)
  R_HISTFILE: ($env.XDG_CONFIG_HOME | path join R/history)
  R_PROFILE_USER: ($env.XDG_CONFIG_HOME | path join R/profile)
  TS_NODE_HISTORY: ($env.XDG_STATE_HOME | path join ts_node_repl_history)
  NPM_CONFIG_INIT_MODULE: ($env.XDG_CONFIG_HOME | path join npm/config/npm-init.js)
  NPM_CONFIG_CACHE: ($env.XDG_CACHE_HOME | path join npm)
  NPM_CONFIG_TMP: ($env.XDG_RUNTIME_DIR | path join npm)
  HISTFILE: ($env.XDG_STATE_HOME | path join bash/history)
  PYTHON_HISTORY: ($env.XDG_STATE_HOME | path join python_history)
  GTK2_RC_FILES: ($env.XDG_CONFIG_HOME | path join gtk-2.0/gtkrc)
  DOT_SAGE: ($env.XDG_CONFIG_HOME | path join sage)
  GCHUP_USE_XDG_DIRS: 'true'
  SQLITE_HISTORY: ($env.XDG_STATE_HOME | path join sqlite_history)
}

