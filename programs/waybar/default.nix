{
  config,
  ...
}:
with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;
let
  waybar_config = {
    mainBar = {
      layer = "top";
      position = "top";
      modules-left = [
        "custom/nix"
        "hyprland/workspaces"
        "niri/workspaces"
        "custom/sep"
        "cpu"
        "memory"
        "custom/sep"
        "mpris"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "network"
        "pulseaudio"
        "custom/sep"
        "custom/notification"
        "tray"
        "custom/power"
      ];
      output = [ "HDMI-A-1" ];
      "hyprland/workspaces" = {
        disable-scroll = true;
        sort-by-name = true;
        format = "{icon}";
        format-icons = {
          empty = "";
          active = "";
          default = "";
        };
        icon-size = 9;
        persistent-workspaces = {
          "*" = 6;
        };
      };
      "niri/workspaces" = {
        all-outputs = false;
        current-only = true;
        format = "{index}";
        disable-click = true;
        disable-markup = true;
      };
      "custom/power" = {
        # Power button
        format = " ";
        tooltip = false;
        on-click = "wlogout";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "sleep 0.1 && task-waybar";
        escape = true;
      };
      cpu = {
        interval = 1;
        format = "  {usage}%";
        max-length = 10;
      };
      network = {
        format-wifi = "  {bandwidthTotalBytes}";
        format-ethernet = "eth {ipaddr}/{cidr}";
        format-disconnected = "net none";
        tooltip-format = "{ifname} via {gwaddr}";
        tooltip-format-wifi = "Connected to: {essid} {frequency} - ({signalStrength}%)";
        tooltip-format-ethernet = "{ifname}";
        tooltip-format-disconnected = "Disconnected";
        max-length = 50;
        interval = 5;
      };
      memory = {
        interval = 2;
        format = "  {used:0.2f}G";
      };
      hyprland.window.format = "{class}";
      tray = {
        icon-size = 18;
        spacing = 10;
      };
      "custom/sep".format = "|";

      mpris = {
        format = "  {title}";
        max-length = 30;
      };

      clock.format = "  {:%a, %d %b, %H:%M}";

      "custom/nix".format = "<span size='large'> </span>";

      pulseaudio = {
        format = "<span size='large'>󰕾 </span> {volume}%";
        format-muted = "  0%";
      };
    };
    secondBar = {
      layer = "top";
      position = "top";
      modules-left = [
        "custom/nix"
        "hyprland/workspaces"
        "niri/workspaces"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "pulseaudio"
        "custom/sep"
        "tray"
      ];
      output = [ "DP-2" ];
      "hyprland/workspaces" = {
        disable-scroll = true;
        sort-by-name = true;
        format = "{icon}";
        format-icons = {
          empty = "";
          active = "";
          default = "";
        };
        icon-size = 9;
        persistent-workspaces = {
          "*" = 6;
        };
      };
      tray = {
        icon-size = 18;
        spacing = 10;
      };
      "custom/sep".format = "|";
      clock.format = "  {:%H:%M}";

      "custom/nix".format = "<span size='large'> </span>";

      pulseaudio = {
        format = "<span size='large'>󰕾 </span> {volume}%";
        format-muted = "  0%";
      };
    };
  };
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = waybar_config;
    style = ''
      * {
        border: none;
        font-family: 'Maple Mono NF CN Medium';
        font-size: 14px;
        font-weight: 500;
        min-height: 0;
      }

      #waybar {
        background: ${base00};
        padding-left: 1.5px;
        padding-right: 1.5px;
      }

      /* Common styling for elements with margin, padding and border-radius */
      #custom-nix, #workspaces, #window, #pulseaudio, #cpu, #memory, #mpris, #clock, #tray, #network {
        margin: 7px;
        padding: 5px;
        padding-left: 8px;
        padding-right: 8px;
        border-radius: 4px;
        background: ${base01};
      }

      #custom-notification {
        margin: 7px;
        padding-left: 8px;
        padding-right: 5px;
        border-radius: 4px 0 0 4px;
        background: ${base01};
        margin-right: 0;
        border: none;
      }
      #custom-power {
        margin: 7px;
        padding: 5px;
        padding-left: 14px;
        padding-right: 14px;
        border-radius: 4px;
        background: ${base01};
        color: ${base08};
        font-weight: bold;
      }

      #workspaces {
        margin: 7px;
        padding: 4.5px;
      }

      #workspaces button {
        padding: 0 2px;
      }

      #workspaces button:hover {
        background: ${base01};
        border: ${base00};
        padding: 0 3px;
      }

      #workspaces button.active {
        color: ${base0E};  /* Active workspace */
      }

      #workspaces button.empty {
        color: ${base03};  /* Empty workspaces */
      }

      #workspaces button.default {
        color: ${base04};  /* Occupied but not active workspaces */
      }

      #workspaces button.special {
        color: ${base0C};  /* Special workspaces */
      }

      #workspaces button.urgent {
        color: ${base08};  /* Urgent workspaces */
      }

      #custom-sep {
        color: ${base02};
      }

      #cpu {
        color: ${base0C};
      }

      #memory {
        color: ${base0A};
      }

      #clock {
        color: ${base0D};
      }

      #mpris {
        color: ${base07};
      }

      #network {
        color: ${base0C};
      }

      #network.disconnected {
        color: ${base09};
      }

      #window {
        color: ${base0D};
      }

      #custom-nix {
        color: ${base0D};
      }

      #pulseaudio {
        color: ${base0B};
      }
    '';
  };
}
