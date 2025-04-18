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
    shellAliases = {
      sv = "sudo nvim";
      fr = "nh os switch --hostname ${host} /home/${username}/cylisos";
      fu = "nh os switch --hostname ${host} --update /home/${username}/cylisos";
      hms = "nh home switch /home/${username}/cylisos/";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v = "nvim";
      cat = "bat";
      ls = "eza --icons";
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      ".." = "cd ..";
      host = "nvim ~/cylisos/hosts/${host}/";
      config = "nvim ~/cylisos/config/";
      rl = "source /home/${username}/.bashrc";
      oo = "cd /home/${username}/Documents/Main/";
      orv = "nvim '/home/${username}/Documents/Main/01 - Rough Notes/'*";
      lz = "lazygit";
    };
  };
}
