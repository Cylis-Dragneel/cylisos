{ host, username, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      #if [ -z "$DISPLAY" ]; then
      #  exec awesome
      #fi
    '';
    initExtra = ''
      nitch
      if [ -f $HOME/.bashrc-personal ]; then
        source $HOME/.bashrc-personal
      fi
    '';
  };
}
