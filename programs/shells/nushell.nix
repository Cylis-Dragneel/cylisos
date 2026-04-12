{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    shellAliases = {
      nix-shell = "nix-shell --command nu";
      nix-develop = "nix develop --command nu";
    };
    extraConfig = ''
      let carapace_completer = {|spans|
        ${pkgs.carapace}/bin/carapace $spans.0 nushell ...$spans | from json
      }
      $env.config = {
        ls: {
          clickable_links: true
        }
        show_banner: false
        edit_mode: "emacs"
        completions: {
          algorithm: "fuzzy"
          case_sensitive: false
          quick: true
          partial: true
          sort: "smart"
          external: {
            enable: true
            max_results:100
            completer: $carapace_completer
          }
        }
        cursor_shape: {
          emacs: underscore
          vi_insert: underscore
          vi_normal: block
        }
        keybindings: [
          {
            name: completion_menu
            modifier: none
            keycode: tab
            mode: [vi_insert vi_normal emacs]
            event: { send: menu name: completion_menu }
          }
          {
            modifier: control
            keycode: char_c
            mode: [emacs vi_insert]
            event: { edit: clear }
          }
        ]
        use_kitty_protocol: true
        render_right_prompt_on_last_line: false
      }
      krabby random
    '';
    extraEnv = ''
      $env.TRANSIENT_PROMPT_COMMAND = "❯ "
      $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
    '';
  };
}
