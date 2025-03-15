{
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      awesomeGit = prev.awesome.overrideAttrs (old: {
        pname = "awesomeGit";
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "master";
          hash = "sha256-IN5sNBDoC6CtBzr3Qp8S9r0rfqR2CD/maGB1aiZdRE4=";
        };
        patches = [ ];

        postPatch = ''
          patchShebangs tests/examples/_postprocess.lua
        '';
      });
    })
    (import (
      builtins.fetchGit {
        url = "https://github.com/nix-community/emacs-overlay.git";
        ref = "master";
        rev = "4ebaf4d0b6b8ab9bacd57f5db199da2d76eea8da";
      }
    ))
  ];
}
