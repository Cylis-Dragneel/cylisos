{ pkgs }:
pkgs.writeShellScriptBin "sesh" # bash
  ''
    if [ "$1" = "connect" ]; then
      ${pkgs.sesh}/bin/sesh connect $(${pkgs.sesh}/bin/sesh list | fzf)
    fi
    if [ "$1" = "cn" ]; then
      ${pkgs.sesh}/bin/sesh connect "$(${pkgs.sesh}/bin/sesh list -i | ${pkgs.gum}/bin/gum filter --limit 1 --placeholder 'Pick A session' --prompt='⚡')"
    fi
  ''
