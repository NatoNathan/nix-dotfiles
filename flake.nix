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

    niri.url = "github:sodiboo/niri-flake";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    catppuccin.url = "github:catppuccin/nix";

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:dc-tec/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:NatoNathan/vicinae";
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
      lanzaboote,
      nixos-cosmic,
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
            };
            username = "natt";
            hostname = "natt-home-pc";
            specialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
              inherit pkgs-stable;
              inherit pkgs-21ef15c;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              catppuccin.nixosModules.catppuccin
              nixos-cosmic.nixosModules.default
              ./hosts/natt-home-pc
              home-manager.nixosModules.home-manager
              {
                nixpkgs.pkgs = pkgs;
                nix.settings = {
                  substituters = [ "https://cosmic.cachix.org/" ];
                  trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = {
                  imports = [
                    ./hosts/natt-home-pc/home.nix
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
            };
            username = "natt";
            hostname = "natt-framework-laptop";
            specialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
              inherit pkgs-stable;
              inherit pkgs-21ef15c;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              catppuccin.nixosModules.catppuccin
              nixos-cosmic.nixosModules.default
              ./hosts/natt-framework-laptop
              nixos-hardware.nixosModules.framework-intel-core-ultra-series1

              home-manager.nixosModules.home-manager
              {
                nixpkgs.pkgs = pkgs;
                nix.settings = {
                  substituters = [ "https://cosmic.cachix.org/" ];
                  trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = {
                  imports = [
                    ./hosts/natt-framework-laptop/home.nix
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
                home-manager.backupFileExtension = "backup";
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
