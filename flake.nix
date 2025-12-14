{
  description = "CylisOS";

  inputs = {
    jerry.url = "github:justchokingaround/jerry";
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    curd = {
      url = "github:Wraient/curd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:unixpariah/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs.url = "github:nix-community/emacs-overlay";
    wakatime-ls = {
      url = "github:mrnossiom/wakatime-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-old,
      home-manager,
      spicetify-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      host = "dragneel";
      username = "cylis";
      system_type = "desktop";
      pkgs-old = import nixpkgs-old {
        inherit system;
      };
      pkgs-stable = import nixpkgs-stable { inherit system; };
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
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
            inputs.stylix.nixosModules.stylix
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  inputs.emacs.overlay
                  inputs.niri.overlays.niri
                ];
                environment.systemPackages = [
                  inputs.zen.packages.${pkgs.stdenv.hostPlatform.system}.twilight
                  inputs.yt-x.packages.${pkgs.stdenv.hostPlatform.system}.default
                  inputs.curd.packages.${pkgs.stdenv.hostPlatform.system}.default
                  inputs.wakatime-ls.packages.${pkgs.stdenv.hostPlatform.system}.default
                ];
              }
            )
          ];
        };
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
          ];
        };
        modules = [
          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                inputs.niri.overlays.niri
              ];
              home.packages = [
                inputs.jerry.packages.${pkgs.stdenv.hostPlatform.system}.default
              ];
            }
          )
          ./hosts/${host}/home.nix
          inputs.stylix.homeModules.stylix
          inputs.jerry.homeManagerModules.default
          inputs.spicetify-nix.homeManagerModules.default
          inputs.nyaa.homeManagerModule
          inputs.niri.homeModules.niri
          inputs.niri.homeModules.stylix
          inputs.noctalia.homeModules.default
        ];
        extraSpecialArgs = {
          inherit
            inputs
            username
            host
            spicetify-nix
            system_type
            ;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
      };
    };
}
