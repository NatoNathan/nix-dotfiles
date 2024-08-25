{
  description = "My Dotfiles Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    ags.url = "github:Aylur/ags";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ...}: {
    nixosConfigurations = {
      natt-home-pc = let 
        username = "natt";
        hostname = "natt-home-pc";
        specialArgs = { inherit inputs; inherit username; inherit hostname; };
      in nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
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