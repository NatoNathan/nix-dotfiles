{
  description = "My Dotfiles Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";

    nixpkgs-21ef15c.url = "github:nixos/nixpkgs/21ef15c";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    catppuccin.url = "github:catppuccin/nix";

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:dc-tec/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-21ef15c,
      nixos-hardware,
      nix-darwin,
      mac-app-util,
      home-manager,
      catppuccin,
      nixvim,
      ...
    }:
    {
      nixosConfigurations = {
        natt-home-pc =
          let
            system = "x86_64-linux";
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-21ef15c = import nixpkgs-21ef15c {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                inputs.hyprpanel.overlay
              ];
            };
            username = "natt";
            hostname = "natt-home-pc";
            specialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
              inherit pkgs-stable;
              inherit pkgs-21ef15c;
              inherit pkgs;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            inherit system;
            modules = [
              catppuccin.nixosModules.catppuccin
              ./hosts/natt-home-pc
              nixos-hardware.nixosModules.framework-13th-gen-intel
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = {
                  imports = [
                    ./home/nixos.nix
                  ];
                };
              }
            ];
          };
        natt-framework-laptop =
          let
            system = "x86_64-linux";
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };

            pkgs-21ef15c = import nixpkgs-21ef15c {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                inputs.hyprpanel.overlay
              ];
            };
            username = "natt";
            hostname = "natt-framework-laptop";
            specialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
              inherit pkgs-stable;
              inherit pkgs-21ef15c;
              inherit pkgs;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            inherit system;
            modules = [
              catppuccin.nixosModules.catppuccin
              ./hosts/natt-framework-laptop

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = {
                  imports = [
                    ./home/nixos.nix
                  ];
                };
              }
            ];
          };

      };

      darwinConfigurations = {
        natt-macbook-pro =
          let
            system = "x86_64-darwin";
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };

            username = "natt";
            hostname = "natt-macbook-pro";
            specialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
              inherit pkgs-stable;
            };
          in
          nix-darwin.lib.darwinSystem {
            inherit system;
            inherit specialArgs;

            modules = [
              mac-app-util.darwinModules.default
              ./hosts/natt-macbook-pro

              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.sharedModules = [
                  mac-app-util.homeManagerModules.default
                ];

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = {
                  imports = [
                    ./home/darwin.nix
                  ];
                };
              }
            ];
          };
      };
    };
}
