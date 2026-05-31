{ lib, ... }:
{
  programs.foot = {
    enable = false;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = lib.mkForce "Maple Mono NF CN Medium:size=11";
        dpi-aware = lib.mkForce "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        alpha = lib.mkForce 0.7;
        # background = lib.mkForce "1e1e2e";
      };
      bell = {
        system = "no";
      };
      cursor = {
        style = "underline";
        blink = "yes";
      };
      text-bindings = {
        "\\x1b\\x7f" = "Control+BackSpace";
      };
    };
  };
}
