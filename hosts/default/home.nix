{
  pkgs,
  username,
  host,
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
    ../../config/rofi/config-emoji.nix
    ../../config/rofi/config-long.nix
    ../../programs
  ];

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
    ];

    shell.enableShellIntegration = true;

    shellAliases = {
      ".." = "cd ..";
      sv = "sudo nvim";
      # fr = "nh os switch --hostname ${host} /home/${username}/cylisos";
      # fu = "nh os switch --hostname ${host} --update /home/${username}/cylisos";
      # hms = "nh home switch /home/${username}/cylisos/";
      fr = "nh os switch";
      fu = "nh os switch --update";
      hms = "nh home switch";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      v = "tmux resize-pane -Z; nvim";
      ls = "eza --icons";
      ll = "eza -lh --icons --grid --group-directories-first";
      la = "eza -lah --icons --grid --group-directories-first";
      host = "nvim ~/cylisos/hosts/${host}/";
      config = "nvim ~/cylisos/config/";
      programs = "nvim ~/cylisos/programs/";
      py-server = "python -m http.server 8040";
      ytmd = "yt-dlp --embed-metadata -x $(ytfzf -I l | grep 'https://')";
      spotd = "spotdl download";
      oo = "cd /home/${username}/Documents/Main/ & nvim +GoToFile";
      orv = "nvim '/home/${username}/Documents/Main/01 - Rough Notes/'*";
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
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
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
    starship.enable = false;
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
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
          starship = {
            enable = true;
            package = pkgs.starship;
          };
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
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style   bold
        inactive_tab_font_style bold
      '';
    };
    home-manager.enable = true;
  };
}
