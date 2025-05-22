{
  config,
  pkgs,
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
    ../../modules/emacs.nix
  ];

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_zen;

    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
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
    image = ../../config/wallpapers/elden-ring-mohg.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    # base16Scheme = {
    #   base00 = "24283B";
    #   base01 = "16161E";
    #   base02 = "343A52";
    #   base03 = "444B6A";
    #   base04 = "787C99";
    #   base05 = "A9B1D6";
    #   base06 = "CBCCD1";
    #   base07 = "D5D6DB";
    #   base08 = "C0CAF5";
    #   base09 = "A9B1D6";
    #   base0A = "0DB9D7";
    #   base0B = "9ECE6A";
    #   base0C = "B4F9F8";
    #   base0D = "2AC3DE";
    #   base0E = "BB9AF7";
    #   base0F = "F7768E";
    # };
    polarity = "dark";
    opacity.terminal = 0.8;
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

  # Extra Module Options
  drivers.amdgpu.enable = true;
  drivers.intel.enable = false;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = host;
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

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
    uwsm = {
      enable = true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri-session";
        };
      };
    };
    nh = {
      package = inputs.nh.packages.${pkgs.system}.default;
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
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = true;
  };

  environment.systemPackages = with pkgs; [
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
    # pokemonsay
    krabby
    ripgrep
    lshw
    bat
    pkg-config
    hyprpicker
    # brightnessctl
    virt-viewer
    swappy
    appimage-run
    networkmanagerapplet
    yad
    inxi
    playerctl
    nixfmt-rfc-style
    libvirt
    swww
    grim
    slurp
    file-roller
    swaynotificationcenter
    imv
    pavucontrol
    tree
    neovide
    greetd.tuigreet
    fzf
    zsh
    gamemode
    deluge-gtk
    zed-editor
    nixd
    vivaldi
    vivaldi-ffmpeg-codecs
    nextcloud-client
    lazygit
    xfce.tumbler
    ffmpegthumbnailer
    luajitPackages.luarocks
    cliphist
    scc
    xorg.xev
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
    # rmpc
    xournalpp
    scrot
    thefuck # Favorite package btw
    exercism
    tldr
    protonvpn-cli
    protonvpn-gui
    pipes-rs
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
    soulseekqt
    yacreader
    ripgrep
    # lutgen
    fd
    spotify
    sshfs
    timg
    # flowtime
    mousam
    freetube
    anup
    libreoffice
    lutris
    wine64
    # wineWow64Packages.waylandFul
    xwallpaper
    # xbindkeys
    polybar
    xwayland-satellite-unstable
    cloudflare-warp
    stremio
    rofi-pass
    corectrl
    yt-dlp
    localsend
    gpodder
    waypaper
    zoom-us
    recordbox
    gapless
    parabolic
    wine-staging
    home-manager
    vimPlugins.nvim-treesitter.withAllGrammars
    dolphin-emu
    duckstation
    heroic
    autorandr
    xorg.libxcvt
    mangohud
    goverlay
    gpu-screen-recorder-gtk
    youtube-music
    redshift
    hyprpaper
    kdePackages.kdenlive
    aseprite
    # libresprite
    audacity
    nitch
    nodejs
    gammastep
    cartridges
    mgba
    ani-cli
    ani-skip
    python3
    ueberzugpp
    chafa
    code-cursor
    nitrogen
    distrobox
    umu-launcher
    cosmic-files
    fish
    helix
    jq
    chromium
    zip
    p7zip
    osu-lazer-bin
    torzu
    imagemagick
    waytrogen
    mpvpaper
    gifsicle
    wf-recorder
    postgresql
    podman-compose
    fluent-reader
    ente-auth
    go
    feishin
    dict
    bruno
    hydralauncher
    (emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-unstable;
      config = ../../config/emacs/config.org;
      alwaysEnsure = true;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: [
        # epkgs.dap-ui
        pkgs.gofumpt
        pkgs.gopls
      ];
    })
    #Awesome related
    xorg.xprop
    xorg.xinit
    # python312Packages.cmake
    # luajitPackages.lgi
    # luajit
    # xorg.xorgproto
    # xorg.libxcb
    # xcb-util-cursor
    # xorg.xcbutil
    # xorg.xcbutilkeysyms
    # cairo
    # pango
    # glib
    # haskellPackages.gio
    xclip
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      symbola
      material-icons
      victor-mono
      iosevka
      departure-mono
      nerd-fonts.jetbrains-mono
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
    postgresql.enable = true;
    tumbler.enable = true;
    geoclue2 = {
      enable = true;
      enableDemoAgent = true;
      enableWifi = true;
    };
    dbus.packages = [ pkgs.gcr ];
    timesyncd.enable = true;
    cloudflare-warp.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs-unstable;
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
        options = "grp:win_space_toggle";
        variant = "";
      };
    };
    # displayManager = {
    #   defaultSession = "plasma";
    #   sddm = {
    #     enable = true;
    #     wayland.enable = true;
    #     # greeter = {
    #     #   theme = "niri";
    #     # };
    #   };
    # };
    # desktopManager.plasma6 = {
    #   enable = true;
    # };
    greetd = {
      enable = true;
      vt = 2;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
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
      enable = true;
    };
    gnome.gnome-keyring = {
      enable = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    # syncthing = {
    #   enable = true;
    #   user = "${username}";
    #   dataDir = "/home/${username}";
    #   configDir = "/home/${username}/.config/syncthing";
    #   settings = {
    #     folders = {
    #       "/home/${username}/Documents/Main" = {
    #         id = "obsidian";
    #         devices = [ "mobile" ];
    #       };
    #     };
    #   };
    # };
    pipewire = {
      enable = true;
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
    flatpak-repo = {
      path = [ pkgs.flatpak ];
      script = ''flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo'';
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
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
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
      amdvlk
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  hardware.amdgpu.opencl.enable = true;
  hardware.i2c.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    53317
    22050
    993
    5432
    4950
    4955
  ];
  networking.firewall.allowedUDPPorts = [
    49152
    4950
    4955
  ];
  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
