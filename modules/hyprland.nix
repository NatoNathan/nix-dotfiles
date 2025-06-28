{ inputs, pkgs, ... }:
{
  security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.greetd.fprintAuth = false;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.login.fprintAuth = false;
  services.gnome.gnome-keyring.enable = true;
  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/$UID";
    #NVD_BACKEND = "direct";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    lxqt.lxqt-policykit
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
  };

  nixpkgs.overlays = [
    # inputs.hyprpanel.overlay
  ];

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

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-hyprland
  #   ];
  # };
}
