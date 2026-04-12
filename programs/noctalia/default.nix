{ ... }:
{
  programs.noctalia-shell = {
    enable = false;
    systemd.enable = true;
    settings = {
      appLauncher = {
        customLaunchPrefix = "uwsm app";
        customLaunchPrefixEnabled = true;
        enableClipPreview = true;
        enableClipboardHistory = true;
        terminalCommand = "ghostty";
        viewMode = "grid";
      };
      bar = {
        floating = true;
        widgets = {
          center = [
            {
              customFont = "";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              useCustomFont = false;
              usePrimaryColor = false;
            }
            # {
            #   characterCount = 2;
            #   followFocusedScreen = false;
            #   hideUnoccupied = false;
            #   id = "Workspace";
            #   labelMode = "index";
            # }
          ];
          left = [

            {
              icon = "rocket";
              id = "CustomButton";
              leftClickExec = "qs -c noctalia-shell ipc call launcher toggle";
              leftClickUpdateText = false;
              maxTextLength = {
                horizontal = 10;
                vertical = 1;
              };
              middleClickExec = "";
              middleClickUpdateText = false;
              parseJson = false;
              rightClickExec = "";
              rightClickUpdateText = false;
              textCollapse = "";
              textCommand = "";
              textIntervalMs = 3000;
              textStream = false;
              wheelDownExec = "";
              wheelDownUpdateText = false;
              wheelExec = "";
              wheelMode = "unified";
              wheelUpExec = "";
              wheelUpUpdateText = false;
              wheelUpdateText = false;
            }
            {
              diskPath = "/home/cylis";
              id = "SystemMonitor";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkStats = false;
              usePrimaryColor = false;
            }
            {
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 145;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = true;
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];
          right = [
            { id = "ScreenRecorder"; }
            {
              colorizeIcons = false;
              drawerEnabled = true;
              id = "Tray";
            }
            {
              hideWhenZero = true;
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              displayMode = "onhover";
              id = "Volume";
            }
            {
              displayMode = "onhover";
              id = "Brightness";
            }
            {
              colorizeDistroLogo = true;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      colorSchemes = {
        predefinedScheme = "Rose Pine";
        useWallpaperColors = true;
      };
      general = {
        avatarImage = "/home/cylis/Pictures/pfp-luffy.png";
      };
      location = {
        name = "Lahore, Pakistan";
      };
      dock = {
        enabled = false;
      };
      brightness = {
        enableDdcSupport = true;
      };
      wallpaper = {
        directory = "/home/cylis/Pictures/Wallpapers";
        enableMultiMonitorDirectories = true;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        monitorDirectories = [
          {
            directory = "/home/cylis/Pictures/Wallpapers/Portrait";
            name = "DP-2";
            wallpaper = "";
          }
          {
            directory = "/home/cylis/Pictures/Wallpapers/Landscape";
            name = "HDMI-A-1";
            wallpaper = "";
          }
        ];
        overviewEnabled = false;
        panelPosition = "follow_bar";
        randomEnabled = false;
        randomIntervalSec = 600;
        recursiveSearch = false;
        setWallpaperOnAllMonitors = false;
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = "random";
        useWallhaven = false;
      };
    };
  };
}
