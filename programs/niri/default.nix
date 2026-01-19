{
  pkgs,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix)
    browser
    terminal
    ;
in
{
  home.packages = [ pkgs.xwayland-satellite ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    settings = {
      input = {
        keyboard = {
          numlock = true;
        };
        touchpad = {
          enable = false;
          tap = true;
          accel-profile = "flat";
          natural-scroll = false;
          scroll-method = "two-finger";
          click-method = "clickfinger";
          tap-button-map = "left-middle-right";
        };
        mouse = {
          accel-profile = "flat";
          natural-scroll = false;
        };
      };
      hotkey-overlay.skip-at-startup = true;
      cursor.hide-when-typing = true;
      outputs = {
        "HDMI-A-1" = {
          mode = {
            height = 1080;
            width = 1920;
            refresh = 239.76;
          };
          scale = 1;
        };
        "DP-2" = {
          mode = {
            height = 1080;
            width = 1920;
            refresh = 74.59;
          };
          scale = 1;
          transform.rotation = 90;
        };
      };
      environment = {
        DISPLAY = ":0";
      };
      prefer-no-csd = true;
      layout = {
        gaps = 10;
        center-focused-column = "never";
        always-center-single-column = true;
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        preset-window-heights = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width.proportion = 0.5;
      };
      spawn-at-startup = [
        {
          command = [
            "uwsm"
            "finalize"
            "FINALIZED=\"I'm here\""
            "WAYLAND_DISPLAY"
          ];
        }
        # {
        #   command = [
        #     "waytrogen"
        #     "--restore"
        #   ];
        # }
        {
          command = [
            "uwsm"
            "app"
            "startup"
          ];
        }
        {
          command = [
            "uwsm"
            "app"
            "xwayland-satellite"
          ];
        }
        {
          command = [
            "uwsm"
            "app"
            "fcitx5"
          ];
        }
      ];
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %d-%m-%Y %H-%M-%S.png";
      animations.enable = true;
      window-rules = [
        {
          geometry-corner-radius =
            let
              radius = 20.0;
            in
            {
              bottom-left = radius;
              bottom-right = radius;
              top-left = radius;
              top-right = radius;
            };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
        {
          matches = [
            {
              title = "Bitwarden - Vivaldi";
            }
          ];
          open-floating = true;
        }
        {
          matches = [ { title = "Picture in picture"; } ];
          open-floating = true;
        }
      ];
      layer-rules = [
        {
          matches = [ { namespace = "^hyprpaper$"; } ];
          place-within-backdrop = true;
        }
      ];
      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = { };
        "Mod+Alt+F" = {
          hotkey-overlay.title = "Toggle floating";
          action.toggle-window-floating = { };
        };
        "Mod+Space" = {
          hotkey-overlay.title = "Noctalia Launcher";
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "toggle"
          ];
        };
        "Mod+P" = {
          hotkey-overlay.title = "Noctalia Power Menu";
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "sessionMenu"
            "toggle"
          ];
        };
        "Mod+Return" = {
          hotkey-overlay.title = "Spawn ${terminal}";
          action.spawn = [
            "${terminal}"
          ];
        };
        "Mod+Shift+Return" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "rofi-launcher"
          ];
        };
        "Mod+D" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "vesktop"
          ];
        };
        "Mod+V" = {
          hotkey-overlay.title = "Clipboard Manager";
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "clipboard"
          ];
        };
        "Mod+W" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "${browser}"
          ];
        };
        "Mod+M" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "spotify"
          ];
        };
        # "Mod+Alt+E" = {
        #   hotkey-overlay.title = "Emoji Picker";
        #   action.spawn = [
        #     "uwsm"
        #     "app"
        #     "emopicker9000"
        #   ];
        # };
        "Mod+Alt+E" = {
          hotkey-overlay.title = "Emoji Picker";
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "emoji"
          ];
        };
        "Mod+Shift+F1" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "curd"
          ];
        };
        "Mod+Alt+L" = {
          hotkey-overlay.title = "Lockscreen";
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "lockScreen"
            "lock"
          ];
        };
        "Mod+E" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "emacsclient"
            "-c"
          ];
        };
        "Mod+O" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "obsidian"
          ];
        };
        "Mod+Alt+O" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "obs"
          ];
        };
        "Mod+Shift+O".action.toggle-overview = { };
        "Mod+S" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "uwsm"
            "app"
            "steam"
          ];
        };
        "Mod+F10" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "pamixer"
            "-i"
            "5"
          ];
        };
        "Mod+F11" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "pamixer"
            "-d"
            "5"
          ];
        };
        "Mod+F12" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "pamixer"
            "-t"
          ];
        };
        "Mod+F9" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
        };
        "Mod+F6" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "brightnessctl"
            "set"
            "+5%"
          ];
        };
        "Mod+F7" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "brightnessctl"
            "set"
            "5%-"
          ];
        };
        "Mod+F1" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "playerctl"
            "prev"
          ];
        };
        "Mod+F2" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "playerctl"
            "play"
          ];
        };
        "Mod+F3" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "playerctl"
            "pause"
          ];
        };
        "Mod+F4" = {
          hotkey-overlay.hidden = true;
          action.spawn = [
            "playerctl"
            "next"
          ];
        };
        "XF86AudioRaiseVolume".action.spawn = [
          "noctalia"
          "volume"
          "increase"
        ];
        "XF86AudioLowerVolume".action.spawn = [
          "noctalia"
          "volume"
          "decrease"
        ];
        "XF86AudioMute".action.spawn = [
          "noctalia"
          "volume"
          "muteOutput"
        ];
        "XF86AudioMicMute".action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
        "XF86MonBrightnessUp".action.spawn = [
          "brightnessctl"
          "set"
          "+5%"
        ];
        "XF86MonBrightnessDown".action.spawn = [
          "brightnessctl"
          "set"
          "5%-"
        ];
        "Mod+Q".action.close-window = { };
        "Mod+0".action.focus-workspace = 10;
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+0".action.move-column-to-workspace = 10;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+H".action.focus-column-left = { };
        "Mod+L".action.focus-column-right = { };
        "Mod+J".action.focus-window-down = { };
        "Mod+K".action.focus-window-up = { };

        "Mod+Shift+H".action.move-column-left = { };
        "Mod+Shift+L".action.move-column-right = { };
        "Mod+Shift+J".action.move-window-down = { };
        "Mod+Shift+K".action.move-window-up = { };

        "Mod+Ctrl+H".action.focus-monitor-left = { };
        "Mod+Ctrl+L".action.focus-monitor-right = { };

        "Mod+Ctrl+Shift+H".action.move-column-to-monitor-left = { };
        "Mod+Ctrl+Shift+L".action.move-column-to-monitor-right = { };

        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.switch-preset-window-height = { };
        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+C".action.center-column = { };

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";
        "Mod+Comma".action.consume-window-into-column = { };
        "Mod+Period".action.expel-window-from-column = { };
        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };
        "Print".action.screenshot = { };
        "Ctrl+Print".action.screenshot-screen = { };
        "Alt+Print".action.screenshot-window = { };
        "Mod+Shift+E".action.quit = { };
        "Mod+Shift+P".action.power-off-monitors = { };
      };
    };
  };
}
