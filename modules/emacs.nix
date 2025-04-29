{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "019q0hm6r05mqiqmfk1zgjqbq5xls4ykh72avdyyh74yhavd1hkb";
      }
    ))
  ];
}
