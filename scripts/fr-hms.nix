{
  pkgs,
}:
pkgs.writeShellScriptBin "fr-hms" # bash
  ''
    nh os switch "$@" && nh home switch
  ''
