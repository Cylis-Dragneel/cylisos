let
  sources = import ./npins { };

  inputs =
    let
      flakeCompat = import sources.flake-compat.outPath;
      mkFlake = source: (flakeCompat { src = source.outPath; }).defaultNix;
    in
    {
      nixpkgs = mkFlake sources.nixpkgs;
      home-manager = mkFlake sources.home-manager_2;
      nixpkgs-old = sources.nixpkgs-old;
      nixpkgs-stable = sources.nixpkgs-stable_3;
      aagl = mkFlake sources.aagl;
      ai-tools = mkFlake sources.ai-tools;
      anime-cursors = sources.anime-cursors;
      curd = mkFlake sources.curd;
      dms = mkFlake sources.dms;
      emacs = mkFlake sources.emacs;
      fine-cmdline = sources.fine-cmdline;
      gazelle = mkFlake sources.gazelle;
      ghostty = mkFlake sources.ghostty;
      helium = {
        packages.${system}.default = import sources.helium-npins.outPath { };
      };
      jerry = mkFlake sources.jerry;
      nh = mkFlake sources.nh;
      niri = mkFlake sources.niri;
      nixvim = mkFlake sources.nixvim;
      noctalia = mkFlake sources.noctalia;
      nyaa = mkFlake sources.nyaa;
      spicetify-nix = mkFlake sources.spicetify-nix;
      stylix = mkFlake sources.stylix;
      wakatime-ls = mkFlake sources.wakatime-ls;
      yt-x = mkFlake sources.yt-x;
      zen = mkFlake sources.zen;
    };

  system = "x86_64-linux";
  host = "dragneel";
  username = "cylis";
  system_type = "desktop";
  pkgs-old = import inputs.nixpkgs-old { inherit system; };
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
in
{
  nixosConfigurations = {
    "${host}" = inputs.nixpkgs.lib.nixosSystem {
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.emacs.overlay
          inputs.niri.overlays.niri
          (_: prev: { openldap = prev.openldap.overrideAttrs { doCheck = false; }; })
          (self: prev: { ratty = self.callPackage ./modules/ratty.nix { }; })
        ];
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "mbedtls-2.28.10" ];
        };
      };
      specialArgs = {
        inherit system;
        inherit inputs;
        inherit username;
        inherit host;
        inherit pkgs-old;
        inherit pkgs-stable;
      };
      modules = [
        ./hosts/${host}/config.nix
        inputs.aagl.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };
  };

  homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.niri.overlays.niri ];
    };
    pkgs-stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    modules = [
      ./hosts/${host}/home.nix
      inputs.stylix.homeModules.stylix
      inputs.nixvim.homeModules.nixvim
      inputs.jerry.homeManagerModules.default
      inputs.spicetify-nix.homeManagerModules.default
      inputs.nyaa.homeManagerModule
      inputs.niri.homeModules.niri
      inputs.niri.homeModules.stylix
      inputs.noctalia.homeModules.default
      inputs.dms.homeModules.dank-material-shell
      inputs.dms.homeModules.niri
      inputs.gazelle.homeModules.gazelle
    ];
    extraSpecialArgs = {
      inherit
        inputs
        username
        host
        system_type
        ;
    };
  };
}
