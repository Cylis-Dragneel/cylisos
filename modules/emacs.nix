{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "07l0ajr80zy5hf1n7anvqw6jbdl0psikd7hi92phcfia34lyxvqg";
      }
    ))
  ];
}
