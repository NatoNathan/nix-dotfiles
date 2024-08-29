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
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    watershot.url = "github:Kirottu/watershot";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, ...}:let 
        system = "x86_64-linux";
        pkgs-stable = import nixpkgs-stable {
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
  in{
    nixosConfigurations = {
      natt-home-pc = let 
        username = "natt";
        hostname = "natt-home-pc";
        specialArgs = { 
          inherit inputs; 
          inherit username; 
          inherit hostname;
          inherit pkgs-stable;
          inherit pkgs;
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