{
  description = "CylisOS";

  inputs = {
    jerry.url = "github:justchokingaround/jerry";
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen.url = "github:0xc000022070/zen-browser-flake";
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    niri.url = "github:sodiboo/niri-flake";
    # umu = {
    #   url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    yt-x.url = "github:Benexl/yt-x";
    curd = {
      url = "github:Wraient/curd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:unixpariah/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    seto = {
      url = "github:unixpariah/seto";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # astal = {
    #   url = "github:aylur/astal";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # aagl = {
    #   url = "github:ezKEa/aagl-gtk-on-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # ags = {
    #   url = "github:aylur/ags/v1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprpanel.url = "github:jas-singhfsu/hyprpanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
    # This is required for plugin support.
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-stable,
      spicetify-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      host = "dragneel";
      username = "cylis";
      system_type = "desktop";
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            ./hosts/${host}/config.nix
            inputs.stylix.nixosModules.stylix
            (
              { pkgs, ... }:
              {
                # imports = [ inputs.aagl.nixosModules.default ];
                # nix.settings = inputs.aagl.nixConfig;
                # programs = {
                #   sleepy-launcher.enable = true;
                #   honkers-railway-launcher.enable = true;
                # };
                nixpkgs.overlays = [
                  inputs.niri.overlays.niri
                ];
                environment.systemPackages = [
                  inputs.zen.packages.x86_64-linux.default
                  pkgs.niri-unstable
                  # inputs.umu.packages.${pkgs.system}.umu
                  inputs.yt-x.packages."${system}".default
                  inputs.curd.packages.${pkgs.system}.default
                ];
              }
            )
          ];
        };
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # pkgs = nixpkgs.legacyPackages.${system};
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
          ];
        };
        modules = [
          {
            nixpkgs.overlays = [
            ];
            home.packages = [
              inputs.jerry.packages.${system}.default
              # inputs.astal.packages.${system}.default
            ];
          }
          ./hosts/${host}/home.nix
          inputs.stylix.homeManagerModules.stylix
          inputs.hyprpanel.homeManagerModules.hyprpanel
          inputs.jerry.homeManagerModules.default
          inputs.spicetify-nix.homeManagerModules.default
          inputs.nyaa.homeManagerModule
          inputs.seto.homeManagerModules.default
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
