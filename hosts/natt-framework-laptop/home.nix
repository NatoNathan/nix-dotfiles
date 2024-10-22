{ inputs, pkgs, ... }:{
  imports = [
    ../../home/nixos.nix
  ];

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1, 2880x1920@120, 0x0, 1.33333333"
    "Unknown-1,disable"
  ];

}
