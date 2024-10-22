{ inputs, pkgs, ... }:{
  imports = [
    ../../home/nixos.nix
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "DP-1, 2560x2880@59.96, -1930x0, 1.3333333"
    "DP-2, 2560x1440@164.96, 0x400, 1"
  ];

  home.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBX_BACKEND = "nvidia-drm";
    GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
