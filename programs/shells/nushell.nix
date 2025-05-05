{
  host,
  username,
  ...
}:
{
  programs.nushell = {
    enable = false;
    shellAliases = {
      nix-shell = "nix-shell --command nu";
      nix-develop = "nix develop --command nu";
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
