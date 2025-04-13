{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "0r5q63rf6i4sm5aaxd915731vbfihhfslnhayr41kmbgkvm02ihr";
      }
    ))
  ];
}
