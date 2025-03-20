{
  pkgs,
  username,
  host,
  inputs,
  lib,
  ...
}:
let
  inherit (import ./variables.nix) gitUsername gitEmail;
in
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";
  home.activation = {
    postActivateScript = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -f "/home/${username}/.config/emacs/config.el" ]; then
        rm /home/${username}/.config/emacs/config.el
      fi
      # if [[ "$0" == *zsh ]]; then
      #   source ~/.zshrc
      # fi
      # if [[ "$0" == *bash ]]; then
      #   source ~/.bashrc
      # fi
      # if [[ "$0" == *nushell ]]; then
      #   source ~/.config/nushell/config.nu
      # fi
    '';
  };

  # Import Program Configurations
  imports = [
    ../../config/emoji.nix
    ../../config/hyprland.nix
    ../../config/neovim.nix
    ../../config/rofi/rofi.nix
    ../../config/rofi/config-emoji.nix
    ../../config/rofi/config-long.nix
    ../../config/swaync.nix
    ../../config/waybar.nix
    ../../config/wlogout.nix
    ../../config/starship/starship.nix
    ../../config/nushell.nix
    ../../modules/overlays.nix
    # inputs.ags.homeManagerModules.default
  ];

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ../../config/wallpapers;
    recursive = true;
  };
  home.file.".config/fastfetch" = {
    source = ../../config/fastfetch;
    recursive = true;
  };
  home.file.".config/awesome" = {
    source = ../../config/awesome;
    recursive = true;
  };
  home.file.".config/ghostty" = {
    source = ../../config/ghostty;
    recursive = true;
  };
  home.file.".config/i3" = {
    source = ../../config/i3;
    recursive = true;
  };
  home.file.".config/jerry" = {
    source = ../../config/jerry;
    recursive = true;
  };
  home.file.".config/anup" = {
    source = ../../config/anup;
    recursive = true;
  };
  home.file.".config/emacs" = {
    source = ../../config/emacs;
    recursive = true;
  };
  home.file.".config/wlogout/icons" = {
    source = ../../config/wlogout;
    recursive = true;
  };
  home.file.".face.icon".source = ../../config/face.jpg;
  home.file.".config/face.jpg".source = ../../config/face.jpg;
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir=/home/${username}/Pictures/Screenshots
    save_filename_format=swappy-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=Ubuntu
    paint_mode=brush
    early_exit=true
    fill_shape=false
  '';

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      color = {
        ui = "auto";
      };
      pull = {
        rebase = false;
      };
    };
  };
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-configtool
    fcitx5-mozc
  ];
  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    configFile."mpv/mpv.conf".text = ''
      --input-ipc-server=/tmp/mpvsocket
      --save-position-on-quit
      ytdl-raw-options=cookies-from-browser=firefox

      # --- bonus mpv tips ---

      # define the quality for mpv to use
      ytdl-format="bestvideo[vcodec^=avc1]+bestaudio/best[vcodec^=avc1]/best"

      # defines where screenshots will be saved
      screenshot-directory=~/Pictures/Screenshots/

      # enable hardware accelaration
      hwdec=vaapi
      vo=gpu
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  xsession = {
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesomeGit;
      };
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # Styling Options
  stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
    kde.enable = false;
    spicetify.enable = false;
    neovim.enable = false;
    tmux.enable = false;
    vesktop.enable = false;
    vscode.enable = false;
    hyprlock.enable = false;
    mpv.enable = false;
  };

  stylix = {
    enable = true;
    image = ../../config/wallpapers/elden-ring-mohg.png;
    base16Scheme = {
      # base00 = "1e1e2e"; # base
      # base01 = "181825"; # mantle
      # base02 = "313244"; # surface0
      # base03 = "45475a"; # surface1
      # base04 = "585b70"; # surface2
      # base05 = "cdd6f4"; # text
      # base06 = "f5e0dc"; # rosewater
      # base07 = "b4befe"; # lavender
      # base08 = "f38ba8"; # red
      # base09 = "fab387"; # peach
      # base0A = "f9e2af"; # yellow
      # base0B = "a6e3a1"; # green
      # base0C = "94e2d5"; # teal
      # base0D = "89b4fa"; # blue
      # base0E = "cba6f7"; # mauve
      # base0F = "f2cdcd"; # flamingo
      base00 = "24283B";
      base01 = "16161E";
      base02 = "343A52";
      base03 = "444B6A";
      base04 = "787C99";
      base05 = "A9B1D6";
      base06 = "CBCCD1";
      base07 = "D5D6DB";
      base08 = "C0CAF5";
      base09 = "A9B1D6";
      base0A = "0DB9D7";
      base0B = "9ECE6A";
      base0C = "B4F9F8";
      base0D = "2AC3DE";
      base0E = "BB9AF7";
      base0F = "F7768E";
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.banana-cursor;
    cursor.name = "Banana";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  # Scripts
  home.packages = [
    (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../../scripts/pdf-viewer.nix { inherit pkgs; })
    (import ../../scripts/task-waybar.nix { inherit pkgs; })
    (import ../../scripts/battery.nix { inherit pkgs; })
    (import ../../scripts/proj.nix { inherit pkgs; })
    (import ../../scripts/clip.nix { inherit pkgs; })
    (import ../../scripts/startup.nix { inherit pkgs username; })
    (import ../../scripts/wallsetter.nix { inherit pkgs username; })
    (import ../../scripts/web-search.nix { inherit pkgs; })
    (import ../../scripts/obsidian-new.nix { inherit pkgs username; })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ../../scripts/screenshootin.nix { inherit pkgs; })
    (import ../../scripts/list-hypr-bindings.nix { inherit pkgs host; })
    (import ../../scripts/fr-hms.nix { inherit pkgs host username; })
    pkgs.hyprpanel
  ];

  programs.nyaa = {
    enable = true;
    download_client = "DefaultApp";
    client.default_app.use_magnet = true;
    source.nyaa.default_sort = "Seeders";
  };
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "/home/${username}/.config/ghostty/tokyonight_storm";
      font-size = 11.3;
      font-family = [
        ""
        "Maple Mono"
      ];
      font-feature = [
        "calt"
        "cv01"
        "cv02"
        "cv03"
        "cv31"
        "ss03"
      ];
      cursor-style = "underline";
      mouse-hide-while-typing = true;
      background-opacity = 0.7;
      background-blur-radius = 15;
      unfocused-split-opacity = 0.7;
      title = "Ghostty";
      keybind = [
        "ctrl+shift+r=reload_config"
        "ctrl+backspace=text:\\x1b\\x7f"
      ];
      window-decoration = false;
      window-theme = "ghostty";
      focus-follows-mouse = false;
      clipboard-read = "allow";
      clipboard-write = "allow";
      confirm-close-surface = false;
      shell-integration-features = "cursor,no-sudo,title";
      term = "xterm-ghostty";
    };
  };
  # programs.ags.enable = true;
  # systemd.user.services.ags = {
  #   Unit = {
  #     Description = "Aylur's Gtk Shell";
  #     PartOf = [
  #       "tray.target"
  #       "graphical-session.target"
  #     ];
  #   };
  #   Service = {
  #     Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
  #     ExecStart = "${cfg.package}/bin/ags -c ${config.xdg.configHome}/ags/config.js";
  #     Restart = "on-failure";
  #   };
  #   Install.WantedBy = [ "graphical-session.target" ];
  # };

  services = {
    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 31.4;
      longitude = 74.2;
    };
    flameshot = {
      enable = true;
      package = pkgs.flameshot;
    };
    picom = {
      enable = true;
      activeOpacity = 1.0;
      inactiveOpacity = 0.8;
      shadow = true;
      shadowOffsets = [
        (-25)
        (-25)
      ];
      shadowOpacity = 0.5;
      fade = false;
      fadeDelta = 3;
      fadeSteps = [
        3.0e-2
        3.0e-2
      ];
      opacityRules = [
        "100:class_g = 'Vivaldi-stable'"
        "100:class_g = 'Rofi'"
        "100:class_g = 'duckstation-qt'"
      ];
      backend = "glx";
      vSync = true;
      settings = {
        blur = {
          method = "gaussian";
          size = 10;
          deviation = 5.0;
        };
        shadow-radius = 25;
      };
    };
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
    # hyprpanel = {
    #   enable = true;
    #   systemd.enable = true;
    #   hyprland.enable = true;
    #   # overwrite.enable = true;
    # };
    mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
        mpris
        sponsorblock
      ];
    };
    carapace = {
      enable = false;
      enableNushellIntegration = true;
    };
    yazi = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    thefuck = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    atuin = {
      enable = false;
      settings = {
        style = "compact";
      };
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    vscode = {
      enable = true;
      profiles = {
        default = {
          extensions =
            with pkgs.vscode-extensions;
            [
              ms-python.python
              ms-python.pylint
              catppuccin.catppuccin-vsc
              catppuccin.catppuccin-vsc-icons
              github.copilot
              github.copilot-chat
              ritwickdey.liveserver
              mechatroner.rainbow-csv
              vscodevim.vim
              golang.go
              eamodio.gitlens
              esbenp.prettier-vscode
              jnoortheen.nix-ide
              arrterian.nix-env-selector
              mkhl.direnv

            ]
            ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              {
                name = "errorlens";
                publisher = "usernamehw";
                version = "3.24.0";
                sha256 = "sha256-Y3M/A5rYLkxQPRIZ0BUjhlkvixDae+wIRUsBn4tREFw=";
              }
              {
                name = "vscode-wakatime";
                publisher = "wakatime";
                version = "25.0.0";
                sha256 = "sha256-n/7y2nbD+ziUCDmNbfuT01GK/ls8rTfghpntj6SmsbA=";
              }
              {
                name = "ripgrep";
                publisher = "jimmyzjx";
                version = "0.4.2";
                sha256 = "sha256-ZP7taq/37rJhbiwD0Vk+6YM6+smjUhC93BFKxcmneMM=";
              }
            ];
          userSettings = {
            "update.mode" = "none";
            "extensions.autoUpdate" = false; # Disable extension auto-updates
            "extensions.autoCheckUpdates" = false; # Disable checking for extension updates

            # Go specific update disabling
            "go.gopath" = ""; # Let the project flake handle the GOPATH
            "go.toolsManagement.checkForUpdates" = "off";

            "editor.cursorBlinking" = "smooth";
            "editor.cursorSmoothCaretAnimation" = "on";
            "editor.wordWrap" = "on";
            "editor.formatOnSave" = true;
            "editor.minimap.enabled" = true;
            "editor.fontFamily" = "Maple Mono";
            "editor.fontLigatures" = true;

            "workbench.colorTheme" = "Catppuccin Macchiato";
            "workbench.iconTheme" = "catppuccin-macchiato";

            "terminal.integrated.fontFamily" = "Maple Mono";

            # Go settings
            "go.useLanguageServer" = true;
            "go.toolsManagement.autoUpdate" = false;
            "go.formatTool" = "goimports";
            "go.lintTool" = "golint";
            "go.testOnSave" = false;

            # Correctly formatted Go settings for Nix
            "[go]" = {
              "editor.insertSpaces" = false;
              "editor.formatOnSave" = true;
              "editor.codeActionsOnSave" = {
                "source.organizeImports" = "always";
              };
            };

            # Go language server settings
            "gopls" = {
              "usePlaceholders" = true;
              "staticcheck" = true;
              "completeUnimported" = true;
              "matcher" = "Fuzzy";
              "analyses" = {
                "nilness" = true;
                "unusedparams" = true;
                "unusedwrite" = true;
                "useany" = true;
              };
            };

            # Debugging
            "go.delveConfig" = {
              "dlvLoadConfig" = {
                "followPointers" = true;
                "maxVariableRecurse" = 1;
                "maxStringLen" = 128;
                "maxArrayValues" = 64;
                "maxStructFields" = -1;
              };
              "apiVersion" = 2;
              "showGlobalVariables" = false;
            };

            # Direnv settings
            "direnv.enable" = true;
            "nix.enableLanguageServer" = true;
          };
          keybindings = [
            {
              key = "ctrl+shift+f";
              command = "ripgrep.find";
            }
          ];
        };
      };

    };
    spicetify = import ../../config/spicetify.nix { inherit pkgs inputs; };
    wezterm = {
      enable = false;
      enableZshIntegration = true;
      extraConfig = ''
        return {
          font = wezterm.font_with_fallback {
                "Pixilized",
                "CozetteHiDpi",
                "koishi",
                "fairfax",
                "JetBrains Mono Nerd Font Mono",
          },
          font_size = 16.0,
          color_scheme = "Catppuccin Macchiato",
          hide_tab_bar_if_only_one_tab = true,
          enable_wayland = false,
        }
      '';
    };
    zsh = import ../../config/zsh.nix { inherit pkgs host username; };
    bash = import ../../config/bash.nix { inherit host username; };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      options = [ "--cmd cd" ];
    };
    tmux = import ../../config/tmux.nix { inherit pkgs; };
    gh.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    kitty = {
      enable = true;
      package = pkgs.kitty;
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
      };
      extraConfig = ''
        font_family Maple Mono
        font_size 11.3
        font_features +calt +cv01 +cv02 +cv03 +cv31 +ss03
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style   bold
        inactive_tab_font_style bold
      '';
    };
    home-manager.enable = true;
    hyprlock = import ../../config/hyprlock.nix { inherit username; };
  };
}
