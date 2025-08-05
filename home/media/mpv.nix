{ pkgs, ... }:
{
  # MPV overlay removed - packages configured globally in flake.nix
  home.packages = [
    pkgs.mpv
  ];
}
