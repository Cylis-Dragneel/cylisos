{
...
}:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
        return {
            # window_background_opacity = 0.7,
            font = wezterm.font_with_fallback {
                    "Maple Mono NF CN Medium",
                    "JetBrainsMono Nerd Font Mono",
                    "Noto Color Emoji",
                    "Pixilized",
                    "CozetteHiDpi",
                    "koishi",
                    "fairfax",
            },
            font_size = 11.0,
            color_scheme = "rose-pine-moon",
            hide_tab_bar_if_only_one_tab = true,
            use_fancy_tab_bar = true,
            enable_wayland = true,
            term = "xterm-256color",
            default_cursor_style = "BlinkingUnderline",
            harfbuzz_features = {
                "calt",
                "cv01",
                "cv02",
                "cv03",
                "cv31",
                "ss03",
            },
        }
    '';
    };
}
