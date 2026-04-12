{ pkgs, ... }:
pkgs.writeShellScriptBin "startup" # bash
  ''
    dbus-update-activation-environment --systemd --all
    systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    lxqt-policykit-agent & disown
    playerctld daemon & disown
    wl-paste --type text --watch cliphist store & disown
    wl-paste --type image --watch cliphist store & disown
    gammastep-indicator & disown
  ''
