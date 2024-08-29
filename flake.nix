{
  description = "My Dotfiles Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    ags.url = "github:Aylur/ags";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, ...}: {
    nixosConfigurations = {
      natt-home-pc = let 
        username = "natt";
        hostname = "natt-home-pc";
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs; 
          inherit username; 
          inherit hostname;
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };
      in nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        inherit system;
        modules = [
          ./hosts/natt-home-pc

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs // specialArgs;
            home-manager.users.${username} = import ./home;
          }
        ];
      };
    };
  };
}