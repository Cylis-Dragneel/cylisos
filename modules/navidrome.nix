{
  lib,
  pkgs,
  config,
  username,
  ...
}:
with lib;
let
  cfg = config.media.navidrome;
in
{
  options.media.navidrome = {
    enable = mkEnableOption "Enable Navidrome";
  };

  config = mkIf cfg.enable {
    services.navidrome = {
      enable = true;
      package = pkgs.navidrome;
      openFirewall = true;
      user = username;
      group = "media";
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        MusicFolder = "/home/${username}/Music";
        DataFolder = "/var/lib/navidrome";
        CacheFolder = "/var/cache/navidrome";
        BaseUrl = "";
        LogLevel = "info";
        EnableInsightsCollector = false;

        Agents = "deezer,lastfm,listenbrainz";
        EnableExternalServices = true;
        Deezer.Enabled = true;
        ListenBrainz.Enabled = true;
        LastFM.Enabled = true;
        LastFM.Language = "en";

        AutoImportPlaylists = true;
        PlaylistsPath = ".";
        DefaultPlaylistPublicVisibility = false;
        EnableSharing = true;
        DefaultDownloadableShare = true;
        DefaultShareExpiration = "8760h";

        EnableDownloads = true;
        AutoTranscodeDownload = true;
        EnableTranscodingConfig = true;
        EnableTranscodingCancellation = true;
        DefaultDownsamplingFormat = "opus";
        FFmpegPath = "${pkgs.ffmpeg}/bin/ffmpeg";
        TranscodingCacheSize = "1GiB";

        EnableArtworkPrecache = true;
        EnableArtworkUpload = true;
        EnableM3UExternalAlbumArt = true;
        EnableMediaFileCoverArt = true;
        ArtistArtPriority = "artist.*, album/artist.*, image-folder, external";
        CoverArtPriority = "cover.*, folder.*, front.*, embedded, external";
        DiscArtPriority = "disc*.*, cd*.*, cover.*, folder.*, front.*, discsubtitle, embedded";
        ImageCacheSize = "512MiB";
        CoverArtQuality = 85;

        EnableFavourites = true;
        EnableStarRating = true;
        EnableNowPlaying = true;
        EnableScrobbleHistory = true;
        EnableReplayGain = true;
        EnableCoverAnimation = true;

        Search.Backend = "fts";
        Search.FullString = true;
        LyricsPriority = ".lrc,.txt,embedded";
        Scanner.Enabled = true;
        Scanner.ScanOnStartup = true;
        Scanner.Schedule = "@every 6h";
        Scanner.WatcherWait = "30s";
        Scanner.FollowSymlinks = true;
        Scanner.PurgeMissing = "full";
        SmartPlaylistRefreshDelay = "30s";

        Plugins.Enabled = true;
        Plugins.AutoReload = true;
        Plugins.CacheSize = "512MiB";

        DefaultTheme = "Dark";
        DefaultLanguage = "en";
        DefaultUIVolume = 100;
        UISearchDebounceMs = 150;
        MaxSidebarPlaylists = 250;
        SessionTimeout = "168h";
      };
    };
  };
}
