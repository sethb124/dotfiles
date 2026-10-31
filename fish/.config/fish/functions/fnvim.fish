function fnvim
  # set file (fd -H -t f | fzf $argv)
  set file (fd -t f . ~/.config ~/Documents/ | fzf $argv)
  if test $file
    nvim $file
  end
end
