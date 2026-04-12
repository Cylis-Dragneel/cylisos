{ pkgs, ... }:
{
  xdg.configFile."mpv/mpv.conf".text = # conf
    ''
      --input-ipc-server=/tmp/mpvsocket
      --save-position-on-quit
      --fullscreen
      --save-watch-history
      --write-filename-in-watch-later-config
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

      # Optimized shaders for lower-end GPU: Mode A (Fast)
      glsl-shaders="~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"
    '';

  xdg.configFile."mpv/input.conf".text = # conf
    ''
      # --- mpv keybindings ---
      n playlist-next
      Shift+n playlist-prev

      s           script-binding uosc/subtitles          #! Subtitles
      a           script-binding uosc/audio              #! Audio tracks
      p           script-binding uosc/items              #! Playlist
      c           script-binding uosc/chapters           #! Chapters
      >           script-binding uosc/next               #! Navigation > Next
      <           script-binding uosc/prev               #! Navigation > Prev
      alt+>       script-binding uosc/delete-file-next   #! Navigation > Delete file & Next
      alt+<       script-binding uosc/delete-file-prev   #! Navigation > Delete file & Prev
      alt+esc     script-binding uosc/delete-file-quit   #! Navigation > Delete file & Quit
      o           script-binding uosc/open-file          #! Navigation > Open file
      #           set video-aspect-override no           #! Utils > Aspect ratio > Default
      #           set video-aspect-override "16:9"       #! Utils > Aspect ratio > 16:9
      #           set video-aspect-override "4:3"        #! Utils > Aspect ratio > 4:3
      #           set video-aspect-override "2.35:1"     #! Utils > Aspect ratio > 2.35:1
      #           script-binding uosc/audio-device       #! Utils > Audio devices
      #           script-binding uosc/editions           #! Utils > Editions
      ctrl+s      async screenshot                       #! Utils > Screenshot
      alt+i       script-binding uosc/keybinds           #! Utils > Key bindings
      O           script-binding uosc/show-in-directory  #! Utils > Show in directory
      #           script-binding uosc/open-config-directory #! Utils > Open config directory
      #           script-binding uosc/update             #! Utils > Update uosc
      esc         quit                                   #! Quit
      U           script-message-to youtube_upnext menu  #! Utils > Youtube Recommendations

      # Optimized shaders for lower-end GPU:
      CTRL+1 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"
      CTRL+2 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"
      CTRL+3 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"
      CTRL+4 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"
      CTRL+5 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_M.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_Soft_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"
      CTRL+6 no-osd change-list glsl-shaders set "~~/shaders/Anime4K_Clamp_Highlights.glsl:~~/shaders/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:~~/shaders/Anime4K_AutoDownscalePre_x2.glsl:~~/shaders/Anime4K_AutoDownscalePre_x4.glsl:~~/shaders/Anime4K_Restore_CNN_S.glsl:~~/shaders/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"

      CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
    '';
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      mpris
      sponsorblock
      youtube-upnext
    ];
  };
  home.packages = with pkgs; [ anime4k ];
}
