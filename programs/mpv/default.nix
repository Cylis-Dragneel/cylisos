{
  pkgs,
  ...
}:
{
  xdg.configFile."mpv/mpv.conf".text = # conf
    ''
      # script-opts=ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp
      --input-ipc-server=/tmp/mpvsocket
      --save-position-on-quit
      --fullscreen
      ytdl-raw-options=cookies-from-browser=firefox

      # --- bonus mpv tips ---

      # define the quality for mpv to use
      ytdl-format="bestvideo[vcodec^=avc1]+bestaudio/best[vcodec^=avc1]/best"
      # ytdl-format="bv+ba/best"

      # defines where screenshots will be saved
      screenshot-directory=~/Pictures/Screenshots/

      # enable hardware accelaration
      hwdec=vaapi
      vo=gpu
    '';

  xdg.configFile."mpv/input.conf".text = # conf
    ''
      # --- mpv keybindings ---
      n playlist-next
      Shift+n playlist-prev

    '';
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
      sponsorblock
    ];
  };
}
