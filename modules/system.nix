{ pkgs, lib, username, ... }: let
  spotify.tcpPorts = [ 57621 ];
  spotify.udpPorts = [ 5353 ];
in {
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "audio" "vidio" ];
    shell = pkgs.zsh;
  };

  nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  fonts.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "FiraCode" "JetBrainsMono" "Gohu" "Hack" "ZedMono" ];
      })
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

  # Enable Flatpak support 
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # Open ports (Use named variables instead of magic numbers, future you will thank you)
  networking.firewall.allowedTCPPorts = spotify.tcpPorts ++ [];
  networking.firewall.allowedUDPPorts = spotify.udpPorts ++ [];
}
