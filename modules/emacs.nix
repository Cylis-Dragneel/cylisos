{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "1bq7phb5hqczbpf5pgi7gm0f9qb0hhzgm7rwhyfb752dgndvackn";
      }
    ))
  ];
}
