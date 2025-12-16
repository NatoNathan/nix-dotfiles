{ inputs, pkgs, lib, config, ... }:
{
  options = {
    niri.enable = lib.mkEnableOption "Niri window manager";
  };

  config = lib.mkIf config.niri.enable {
    # Import niri module from flake
    imports = [ inputs.niri.nixosModules.niri ];

    # Enable niri
    programs.niri.enable = true;

    # Security and authentication
    security.polkit.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
    security.pam.services.greetd.fprintAuth = false;
    security.pam.services.login.enableGnomeKeyring = true;
    security.pam.services.login.fprintAuth = false;
    services.gnome.gnome-keyring.enable = true;

    # Environment variables for Niri
    environment.variables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
      NIXOS_OZONE_WL = "1";
    };

    # Required packages for Niri
    environment.systemPackages = with pkgs; [
      wl-clipboard
      libsecret
      wireplumber
      xdg-desktop-portal-gnome
      kdePackages.qtwayland
      libsForQt5.qt5.qtwayland
      kdePackages.qtsvg
      kdePackages.kio-fuse
      kdePackages.kio-extras
    ];

    # Audio support
    services.pipewire.enable = true;

    # XDG portal configuration for Niri
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
      ];
    };
  };
}