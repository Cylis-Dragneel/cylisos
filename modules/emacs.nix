{
  ...
}:
{
  nixpkgs.overlays = [
    (import (
      builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        sha256 = "1w5kynklgg1g05wmd8sldn0jqnlj4js48l66d0fdiv1kbgfphr07";
      }
    ))
  ];
}
