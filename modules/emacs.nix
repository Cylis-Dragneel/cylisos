{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "0w0bzza7dqf2gj4bbw20cgr3nqwpnc7rcnhkak4jgs6dj7fpsr1y";
      }
    ))
  ];
}
