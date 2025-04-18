{ pkgs }:
pkgs.writeShellScriptBin "clip" # bash
  ''
    selection=$(${pkgs.cliphist}/bin/cliphist list | ${pkgs.rofi-wayland}/bin/rofi -dmenu | ${pkgs.cliphist}/bin/cliphist decode)
    printf "$selection" | ${pkgs.wl-clipboard}/bin/wl-copy
    printf "$selection" | ${pkgs.xclip}/bin/xclip -selection clipboard
  ''
