{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
  ];
  home.packages = with pkgs; [
    hyprshot
  ];
}
