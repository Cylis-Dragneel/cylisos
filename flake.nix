{
  description = "CylisOS";

  inputs = {
    jerry.url = "github:justchokingaround/jerry";
    nyaa = {
      url = "github:Beastwick18/nyaa";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
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
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # aagl = {
    #   url = "github:ezKEa/aagl-gtk-on-nix";
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
      pkgs-stable = import nixpkgs-stable {
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
            inherit pkgs-stable;
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
                  inputs.zen.packages.${pkgs.system}.twilight
                  pkgs.niri-unstable
                  inputs.yt-x.packages.${pkgs.system}.default
                  inputs.curd.packages.${pkgs.system}.default
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
            inputs.hyprpanel.overlay
          ];
        };
        modules = [
          {
            nixpkgs.overlays = [
            ];
            home.packages = [
              inputs.jerry.packages.${system}.default
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
