{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "13izgryfh69kr84dl7wpkas2z0w8yc5s09mqlgl8yhyffzvzfnzi";
      }
    ))
  ];
}
