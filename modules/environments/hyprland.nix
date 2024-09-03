{ inputs, pkgs, ... }:
{
  security.polkit.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/$UID";
    NVD_BACKEND = "direct";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    lxqt.lxqt-policykit
    libsecret
    wireplumber
    xdg-desktop-portal-hyprland
    nvidia-vaapi-driver
  ];
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  programs.seahorse.enable = true;

  services.pipewire.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-hyprland
  #   ];
  # };
}
