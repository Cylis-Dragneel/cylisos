{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "1mkmz098hg9za14mmv5n2r07wmzvw70b0kp7g9grrlnwyn0mpfl4";
      }
    ))
  ];
}
