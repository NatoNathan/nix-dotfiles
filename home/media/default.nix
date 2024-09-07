{ pkgs, pkgs-stable, ... }:
{

  home.packages = [
    pkgs-stable.spotify
    # pkgs.mpv
  ];

  # programs.obs-studio = {
  #   enable = true;
  # };
}
