{
  ...
}:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      scrollback_lines = 2000;
      wheel_scroll_min_lines = 1;
      window_padding_width = 4;
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      font_family Maple Mono NF CN Medium
      font_size 11
      font_features +calt +cv01 +cv02 +cv03 +cv31 +ss03
      tab_bar_style fade
      tab_fade 1
      active_tab_font_style medium
      inactive_tab_font_style medium
      # background_opacity 0.7
      include rose-pine-moon.conf
      map ctrl+backspace send_text all \x17
    '';
  };
}
