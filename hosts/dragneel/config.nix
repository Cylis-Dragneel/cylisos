{
  config,
  pkgs,
  pkgs-old,
  pkgs-stable,
  host,
  inputs,
  username,
  options,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/amd-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/overlays.nix
    ../../modules/navidrome.nix
  ];

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    # Bootloader.
    loader = {
      timeout = 15;
      limine = {
        enable = true;
        enableEditor = true;
        style = {
          wallpapers = [
            "/home/${username}/Pictures/Wallpapers/Landscape/wallhaven_gwwvqe.jpg"
            "/home/${username}/Pictures/Wallpapers/Landscape/wallhaven_g8j113.jpg"
            "/home/${username}/Pictures/Wallpapers/Landscape/cantarella-14909.jpg"
          ];
          # backdrop = "1e1e2e";
        };
      };
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };

  # Styling Options
  stylix = {
    enable = true;
    image = ../../config/wallpapers/Landscape/carlotta_1.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    opacity.terminal = 0.7;
    # cursor.package = pkgs.banana-cursor;
    # cursor.name = "Banana";
    # cursor.size = 32;
    cursor = {
      # name = "touhou-reimu";
      # package = inputs.anime-cursors.packages.${pkgs.stdenv.hostPlatform.system}.cursors;
      name = "chisa-cursor";
      package = pkgs.callPackage ../../modules/chisa-cursor.nix { };
      size = 48;
    };
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

  # Extra Module Options
  drivers.amdgpu.enable = true;
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;
  media.navidrome = {
    enable = true;
    environmentFile = "/var/lib/secrets/navidrome.env";
  };

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      insertNameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
      ];
      dns = "systemd-resolved";
    };
    hostName = host;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [
        3000
        53317
        22050
        993
        5432
        25565
      ];
      allowedUDPPorts = [
        49152
        4950
        4955
      ];
    };
    enableIPv6 = false;
    resolvconf.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Asia/Karachi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs = {
    kdeconnect.enable = true;
    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Compositor managed by UWSM";
          binPath = "${pkgs.niri-unstable}/bin/niri-session";
        };
      };
    };
    nh = {
      enable = true;
      flake = "/home/${username}/cylisos";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 3 --keep-since 3d";
      };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
    ssh.startAgent = false;
    ssh.askPassword = lib.mkForce "${pkgs.seahorse}libexec/seahorse/ssh-askpass";
    zsh.enable = true;
    nano.enable = false;
    gamemode.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    };
    virt-manager.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ "mbedtls-2.28.10" ];
    };
  };

  users = {
    mutableUsers = true;
  };

  environment.systemPackages =
    (with pkgs; [
      vim
      wget
      killall
      eza
      git
      cmatrix
      lolcat
      fastfetch
      htop
      libvirt
      lxqt.lxqt-policykit
      lm_sensors
      unzip
      unrar
      libnotify
      v4l-utils
      ydotool
      duf
      ncdu
      wl-clipboard
      pciutils
      ffmpeg-full
      socat
      krabby
      ripgrep
      lshw
      bat
      pkg-config
      hyprpicker
      virt-viewer
      swappy
      appimage-run
      networkmanagerapplet
      yad
      inxi
      playerctl
      nixfmt
      libvirt
      awww
      grim
      slurp
      file-roller
      swaynotificationcenter
      imv
      pavucontrol
      tree
      neovide
      tuigreet
      fzf
      zsh
      gamemode
      zed-editor
      nixd
      vivaldi
      vivaldi-ffmpeg-codecs
      lazygit
      tumbler
      ffmpegthumbnailer
      luajitPackages.luarocks
      cliphist
      scc
      xev
      wev
      pamixer
      gimp3
      # inkscape
      vesktop
      obsidian
      gitleaks
      nvtopPackages.amd
      amberol
      pass
      # xournalpp
      scrot
      pay-respects # New favorite package
      exercism
      tldr
      proton-vpn
      spotdl
      screenkey
      radeontop
      aria2
      foliate
      cmus
      cmusfm
      zathura
      vlc
      qalculate-gtk
      jdk
      yazi
      figlet
      nicotine-plus
      yacreader
      ripgrep
      fd
      spotify
      sshfs
      timg
      mousam
      freetube
      anup
      libreoffice
      lutris
      wine64
      xwallpaper
      polybar
      cloudflare-warp
      # stremio
      corectrl
      localsend
      gpodder
      waypaper
      zoom-us
      gapless
      parabolic
      wine-staging
      home-manager
      vimPlugins.nvim-treesitter.withAllGrammars
      heroic
      autorandr
      libxcvt
      # mangohud
      # goverlay
      gpu-screen-recorder-gtk
      pear-desktop
      redshift
      hyprpaper
      kdePackages.kdenlive
      # aseprite
      # libresprite
      # audacity
      nitch
      nodejs
      gammastep
      cartridges
      mgba
      ani-cli
      python3
      ueberzugpp
      chafa
      nitrogen
      distrobox
      umu-launcher
      cosmic-files
      jq
      zip
      p7zip
      osu-lazer-bin
      imagemagick
      waytrogen
      mpvpaper
      wf-recorder
      postgresql
      podman-compose
      fluent-reader
      piper
      go
      dict
      bruno
      hydralauncher
      nix-index
      lact
      protonplus
      pipeline
      trackma-gtk
      tuba
      discord
      jujutsu
      just
      pokemmo-installer
      jellyfin-rpc
      tsukimi
      jellytui
      android-tools
      cozy
      bluetui
      # maa-assistant-arknights
      # maa-cli
      grayjay
      fcast-receiver
      fcast-client
      seanime
      opencode
      ytcast
      go2tv
      isponsorblocktv
      popcorntime
      kdePackages.kasts
      rclone
      gallery-dl
      gh-dash
      libretro.swanstation
      azahar
      dolphin-emu
      maa-assistant-arknights
      maa-cli
      feishin
      aonsoku
      (callPackage ../../modules/anymex.nix { })
      # android-studio
      (emacsWithPackagesFromUsePackage {
        package = pkgs.emacs-unstable;
        config = ../../config/emacs/config.org;
        alwaysEnsure = true;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [
          # LSP servers and formatters
          pkgs.gofumpt
          pkgs.gopls
        ];
      })
      #Awesome related
      xprop
      xinit
      xclip
    ])
    ++ (with pkgs-old; [ torzu ])
    ++ (with pkgs-stable; [ yt-dlp ]);

  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      font-awesome
      symbola
      material-icons
      victor-mono
      iosevka
      departure-mono
      nerd-fonts.jetbrains-mono
      liberation_ttf
    ];
  };

  environment.variables = {
    FZF_DEFAULT_OPTS = ''
      --height 60%
      --layout=reverse
      --border
      --inline-info
      --preview 'bat --style=numbers --color=always {}'

    '';
    CYLISOS_VERSION = "1.0";
    CYLISOS = "true";
    ROC_ENABLE_PRE_VEGA = "1";
    HSA_OVERRIDE_GFX_VERSION = "8.0.0";
    AMD_VULKAN_ICD = "RADV";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal
      xdg-desktop-portal-gnome
    ];
  };

  # Services to start
  services = {
    audiobookshelf.enable = true;
    resolved = {
      enable = true;
      settings.Resolve.DNSStubListener = true;
    };
    flaresolverr.enable = true;
    homepage-dashboard = {
      enable = true;
      allowedHosts = "dragneel:8082";

      widgets = [
        {
          type = "resources";
          label = "System";
          cpu = true;
          memory = true;
          disk = "/";
          uptime = true;
        }
        {
          type = "datetime";
          locale = "en";
          format = {
            timeStyle = "short";
            hourCycle = "h23";
            dateStyle = "medium";
          };
        }
      ];

      services = [
        {
          "Media" = [
            {
              "Jellyfin" = {
                icon = "jellyfin.png";
                href = "http://dragneel:8096";
                description = "Media Server";
                widget = {
                  type = "jellyfin";
                  url = "http://localhost:8096";
                  key = "cfaba9595fe1428f8c459a4e06bcce5b"; # optional, for stats
                };
              };
            }
            {
              "Komga" = {
                icon = "komga.png";
                href = "http://dragneel:8080";
                description = "Comic/Manga Server";
                widget = {
                  type = "komga";
                  url = "http://localhost:8080";
                  username = "cylis.dragneel@gmail.com";
                  password = "25831";
                };
              };
            }
          ];
        }
        {
          "Downloads" = [
            {
              "Sonarr" = {
                icon = "sonarr.png";
                href = "http://dragneel:8989";
                description = "TV Show Manager";
                widget = {
                  type = "sonarr";
                  url = "http://localhost:8989";
                  key = "b54c04fa09b345b78027c517e432871b";
                  enableQueue = true;
                };
              };
            }
            {
              "Prowlarr" = {
                icon = "prowlarr.png";
                href = "http://dragneel:9696";
                description = "Indexer Manager";
                widget = {
                  type = "prowlarr";
                  url = "http://localhost:9696";
                  key = "e589307e37e141be88d9e55d4adc0b01";
                };
              };
            }
            {
              "Deluge" = {
                icon = "deluge.png";
                href = "http://dragneel:8112";
                description = "Torrent Client";
                widget = {
                  type = "deluge";
                  url = "http://localhost:8112";
                  password = "deluge"; # plain text, or use secrets
                };
              };
            }
          ];
        }
        {
          "Sync" = [
            {
              "Syncthing" = {
                icon = "syncthing.png";
                href = "http://localhost:8384";
                description = "File Sync";
              };
            }
          ];
        }
      ];

      # Optional: themes, bookmarks, etc.
      bookmarks = [
        {
          Developer = [
            {
              NixOS = [
                {
                  abbr = "Nix";
                  href = "https://search.nixos.org/packages";
                  icon = "nixos.png";
                }
              ];
            }
            {
              GitHub = [
                {
                  abbr = "GH";
                  href = "https://github.com";
                  icon = "github.png";
                }
              ];
            }
          ];
        }

      ];

      settings = {
        title = "My Homelab";
        theme = "dark";
        color = "slate";
        layout = {
          Media = {
            style = "row";
            columns = 3;
          };
        };
      };
    };
    komga = {
      enable = true;
      settings = {
        server.port = 8080;
      };
    };
    sonarr = {
      enable = true;
      user = "cylis";
      group = "media";
      dataDir = "/home/${username}/Downloads/Sonarr";
    };
    prowlarr.enable = true;
    radarr = {
      enable = true;
      user = "cylis";
      group = "media";
      dataDir = "/home/${username}/Downloads/Radarr";
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    bazarr = {
      enable = true;
      group = "media";
    };
    deluge = {
      enable = true;
      user = "${username}";
      group = "media";
      web = {
        enable = true;
        port = 8112;
      };
      declarative = true;
      config = {
        download_location = "/home/${username}/Downloads";
        allow_remote = true;
        listen_ports = [
          6881
          6891
        ];
        enabled_plugins = [
          "Label"
          "WebUi"
        ];
        sequential_download = true;
        auto_managed = true;
        max_active_limit = 20;
        max_active_downloading = 1;
        max_active_seeding = 19;
      };
      openFirewall = true;
      authFile = "/home/${username}/.config/deluge/auth";
    };
    lact.enable = true;
    ratbagd.enable = true;
    postgresql.enable = true;
    tumbler.enable = true;
    # geoclue2 = {
    #   enable = true;
    #   enableDemoAgent = true;
    #   enableWifi = true;
    # };
    dbus.packages = [ pkgs.gcr ];
    ollama = {
      enable = false;
      package = pkgs.ollama-vulkan;
    };
    timesyncd.enable = true;
    cloudflare-warp.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
    };
    kmonad = {
      enable = true;
      keyboards.main = {
        device = "/dev/input/by-path/pci-0000:00:14.0-usbv2-0:10:1.0-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
        };
        config = ''
          (defsrc
            caps
            ralt
          )

          (defalias
            caps-esc-ctrl (tap-hold-next-release 170 esc lctl)
          )

          (deflayer base
            @caps-esc-ctrl
            bspc
          )
        '';
      };
    };
    kanata = {
      enable = false;
      keyboards = {
        main = {
          config = ''
            (defsrc
              caps
              ralt
            )
            (defvar
              tap 200
              hold 200
            )
            (defalias 
              caps (tap-hold $tap $hold esc lctl)
            )
            (deflayer base
              @caps
              bspc
            )
          '';
        };
      };
    };
    tailscale.enable = true;
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager.startx.enable = true;
      desktopManager = {
        xfce = {
          enable = true;
          enableXfwm = false;
          noDesktop = true;
        };
      };
      windowManager.i3.enable = true;
      xkb = {
        layout = "us,jp";
        options = "grp:win_shift_space_toggle";
        variant = "";
      };
    };
    displayManager.cosmic-greeter.enable = false;
    desktopManager.cosmic.enable = false;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start -F niri-session' -g 'Kill Yourself!' --remember --user-menu";
        };
      };
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    fstrim.enable = true;
    gvfs.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
    flatpak.enable = true;
    printing = {
      enable = false;
    };
    gnome.gnome-keyring = {
      enable = true;
    };
    avahi = {
      enable = false;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
      audio.enable = true;
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
  };
  systemd.user.services.xdg-desktop-portal = {
    environment = {
      XDG_CURRENT_DESKTOP = "niri";
    };
  };
  systemd.services = {
    kmonad-main = {
      serviceConfig.User = lib.mkForce "root";
    };
    flatpak-repo = {
      path = [ pkgs.flatpak ];
      script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
    };
    warp-log-cleanup = {
      description = "Clean up Cloudflare WARP logs";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'find /var/lib/cloudflare-warp/qlogs -type f -mtime +7 -delete'";
      };
    };
    cloudflare-warp.environment = {
      WARP_DEBUG_LEVEL = "error";
    };
    sponsorblock = {
      description = "Sponsorblock for Youtube on TV";
      wants = [ "network-online.target" ];
      after = [
        "network-online.target"
        "multi-user.target"
      ];
      wantedBy = [
        "multi-user.target"
        "default.target"
      ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.isponsorblocktv}/bin/iSponsorBlockTV";
        Restart = "always";
        TimeoutStartSec = 900;
        User = "${username}";
      };
    };
    virt-secret-init-encryption.enable = false;
  };
  systemd.timers = {
    warp-log-cleanup = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };

  # Bluetooth Support
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  security.pam.services.hyprlock = {
    text = ''
      auth include login
    '';
  };

  # Optimization settings and garbage collection automation
  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.garnix.io"
        "https://ghostty.cachix.org"
        "https://niri.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://ezkea.cachix.org"
        "https://cosmic.cachix.org/"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  # OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };
  hardware.amdgpu.opencl.enable = true;
  hardware.i2c.enable = true;
  hardware.enableAllFirmware = true;

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
