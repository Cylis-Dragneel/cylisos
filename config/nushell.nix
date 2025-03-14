{
  host,
  username,
  ...
}:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
      sv = "sudo nvim";
      fr = "nh os switch --hostname ${host} /home/${username}/cylisos/";
      fu = "nh os switch --hostname ${host} --update /home/${username}/cylisos/";
      v = "nvim";
      l = "ls";
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      ".." = "cd ..";
      host = "nvim /home/${username}/hosts/${host}/";
      config = "nvim /home/${username}/cylisos/config/";
      py-server = "python -m http.server 8040";
      cmc = "cmus-remote -C 'clear'";
      cma = "cmus-remote -C 'add ~/Music'";
      cmu = "cmus-remote -C 'update-cache -f'";
      nix-shell = "nix-shell --command nu";
      nix-develop = "nix develop --command nu";
      oo = "cd /home/${username}/Documents/Main/";
      orv = "nvim '/home/${username}/Documents/Main/01 - Rough Notes/'*";
      lz = "lazygit";
    };
    extraConfig = ''
      $env.config = {
        show_banner: false
        completions: {
          algorithm: "prefix"
          sort: "smart"
          external: {
            enable: true
            max_results:10
          }
        }
        cursor_shape: {
          emacs: underscore
        }
        use_kitty_protocol: true
        render_right_prompt_on_last_line: false
      }
      krabby random
    '';
    extraEnv = ''
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
    '';
  };
}
