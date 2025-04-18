{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "0n4qd7l9kk48z2fw00jibn8j1cx20mqsvfdvpr1ivpbl4r4wwqcd";
      }
    ))
  ];
}
