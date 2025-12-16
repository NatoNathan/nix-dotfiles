{ inputs, pkgs, lib, ... }:
{
  imports = [
    ../../home/nixos.nix
    # Uncomment to enable additional desktop environments
    # ../../home/environments/niri.nix
    # ../../home/environments/cosmic.nix
  ];

  # Monitor configuration for Hyprland (default)
  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1, 2880x1920@120, 0x0, 1.5"
    "Unknown-1,disable"
  ];
}
