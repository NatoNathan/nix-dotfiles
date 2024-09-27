{
  pkgs,
  lib,
  username,
  ...
}:
{

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [username];
    substituters = [
      "https://cache.nixos.org/"
      "https://devenv.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerdfonts
    # (nerdfonts.override {
    #   fonts = [
    #     "FiraCode"
    #     "JetBrainsMono"
    #     "Gohu"
    #     "Hack"
    #     "ZedMono"
    #     "Symbols"
    #   ];
    # })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    neovim
    neofetch
  ];

  programs.zsh.enable = true;
}
