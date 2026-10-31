function hy --wraps='cd ~/.config/hyprland && nvim hyprland.conf' --wraps='cd ~/.config/hypr && nvim hyprland.conf' --description 'alias hy cd ~/.config/hypr && nvim hyprland.conf'
  cd ~/.config/hypr && nvim hyprland.conf $argv
        
end
