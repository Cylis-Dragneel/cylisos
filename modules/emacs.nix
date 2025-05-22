{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "18vy5q57hvh74mzpkfp8q6xl36139wfp6hcr2m51fcfx6qslf9lj";
      }
    ))
  ];
}
