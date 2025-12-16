{ inputs, pkgs, lib, config, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "Hyprland window manager";
  };

  config = lib.mkIf config.hyprland.enable {
    # Required for XDG portals with home-manager
    environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

    security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.greetd.fprintAuth = false;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.login.fprintAuth = false;
  services.gnome.gnome-keyring.enable = true;
  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/$UID";
    NIXOS_OZONE_WL = "1";  # Enable Wayland for Electron/Chromium apps
    #NVD_BACKEND = "direct";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    hyprpolkitagent
    libsecret
    wireplumber
    xdg-desktop-portal-hyprland
    kdePackages.qtwayland
    libsForQt5.qt5.qtwayland
    kdePackages.qtsvg
    kdePackages.kio-fuse
    kdePackages.kio-extras
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    withUWSM = true;  # Recommended by NixOS wiki for session management
    xwayland.enable = true;  # Enable XWayland support for X11 apps
  };


  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  programs.seahorse.enable = true;

  services.pipewire.enable = true;

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # Enable XDG portals (required for Flatpak and screensharing)
  xdg.portal.enable = true;
  };
}
