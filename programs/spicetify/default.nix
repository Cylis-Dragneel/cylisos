{ inputs, pkgs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullScreen
      volumePercentage
      showQueueDuration
      goToSong
      powerBar
      skipOrPlayLikedSongs
      # volumeProfiles
      playNext
      history
      keyboardShortcut
      shuffle
      phraseToPlaylist
      betterGenres
      lastfm
    ];
    # theme = spicePkgs.themes.nightlight;
    theme = spicePkgs.themes.ziro;
    colorScheme = "rose-pine-moon";
    # theme = {
    #   name = "Retro";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "Motschen";
    #     repo = "Retroblur";
    #     rev = "685cf3aea4ed1a4d82f687293f0efb5baa1aec06";
    #     hash = "sha256-YAOmeSAxD0qR8Y7t+HOBoTCJtiJNfveJCmiptfg25OE=";
    #   };
    # };
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "macchiato";
  };
}
