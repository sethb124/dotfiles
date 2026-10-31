function fopen
  set file (fd -t f | fzf $argv)
  if test $file
    xdg-open $file
  end
end
