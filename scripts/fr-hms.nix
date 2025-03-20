{
  pkgs,
  host,
  username,
}:
pkgs.writeShellScriptBin "fr-hms" # bash
  ''
    nh os switch --hostname ${host} /home/${username}/cylisos "$@" && nh home switch /home/${username}/cylisos/
  ''
