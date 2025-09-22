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
  # Import Program Configurations
  imports = [
    ../../modules/overlays.nix
    ../../config/emoji.nix
    ../../config/neovim.nix
    ../../programs/rofi/config-emoji.nix
    ../../programs/rofi/config-long.nix
    ../../programs
  ];

  # Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
    activation = {
      postActivateScript = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ -f "/home/${username}/.config/emacs/config.el" ]; then
          rm /home/${username}/.config/emacs/config.el
          ${pkgs.killall}/bin/killall emacs
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

    # Place Files Inside Home Directory
    file = {
      "Pictures/Wallpapers" = {
        source = ../../config/wallpapers;
        recursive = true;
      };
      ".config/fastfetch" = {
        source = ../../config/fastfetch;
        recursive = true;
      };
      ".config/ghostty" = {
        source = ../../config/ghostty;
        recursive = true;
      };
      ".config/awesome" = {
        source = ../../config/awesome;
        recursive = true;
      };
      ".config/i3" = {
        source = ../../config/i3;
        recursive = true;
      };
      ".config/jerry" = {
        source = ../../config/jerry;
        recursive = true;
      };
      ".config/anup" = {
        source = ../../config/anup;
        recursive = true;
      };
      ".config/emacs" = {
        source = ../../config/emacs;
        recursive = true;
      };
      ".config/sesh" = {
        source = ../../config/sesh;
        recursive = true;
      };
      ".config/wlogout/icons" = {
        source = ../../programs/wlogout/icons;
        recursive = true;
      };
      ".config/kitty" = {
        source = ../../config/kitty;
        recursive = true;
      };
      ".face.icon".source = ../../config/face.jpg;
      ".config/face.jpg".source = ../../config/face.jpg;
      ".config/swappy/config".text = ''
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
    };

    # Scripts
    packages = [
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
      (import ../../scripts/fr-hms.nix { inherit pkgs; })
      (import ../../scripts/sesh.nix { inherit pkgs; })
      pkgs.hyprpanel
    ];

    shell.enableShellIntegration = true;

    shellAliases = {
      sv = "sudo hx";
      fr = "nh os switch";
      fu = "nh os switch --update";
      hms = "nh home switch";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      ls = "eza --icons";
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      host = "hx ~/cylisos/hosts/${host}/";
      config = "hx ~/cylisos/config/";
      programs = "hx ~/cylisos/programs/";
      spotd = "spotdl download";
      oo = "cd /home/${username}/Documents/Main/";
      orv = "hx '/home/${username}/Documents/Main/01 - Rough Notes/'*";
      lz = "lazygit";
      emd = "emacs --daemon";
      emc = "emacsclient -c .";
      zed = "zeditor --foreground ./";
      pod-up = "podman-compose up -d";
      pod-down = "podman-compose down";
    };
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    extraConfig = {
      init.defaultBranch = "main";
      color.ui = "auto";
      pull.rebase = false;
      alias = {
        pr = "pull --rebase";
      };
    };
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-configtool
      fcitx5-mozc
    ];
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
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
    helix.enable = false;
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
    starship.enable = false;
  };

  stylix = {
    enable = true;
    image = ../../config/wallpapers/elden-ring-mohg.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    polarity = "dark";
    opacity.terminal = 0.7;
    cursor.package = pkgs.banana-cursor;
    cursor.name = "Banana";
    cursor.size = 32;
    fonts = {
      monospace = {
        # package = pkgs.nerd-fonts.jetbrains-mono;
        package = pkgs.maple-mono.NF-CN;
        # name = "JetBrainsMono Nerd Font Mono";
        name = "Maple Mono";
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
    fzf = {
      enable = true;
    };
    nyaa = {
      enable = true;
      download_client = "DefaultApp";
      client.default_app.use_magnet = true;
      source.nyaa.default_sort = "Date";
    };
    carapace = {
      enable = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };
    yazi = {
      enable = true;
    };
    pay-respects = {
      enable = true;
    };
    atuin = {
      enable = false;
      settings = {
        style = "compact";
      };
      enableZshIntegration = false;
      enableFishIntegration = false;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
    gh.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    home-manager.enable = true;
  };
}
