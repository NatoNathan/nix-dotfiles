{ pkgs, pkgs-stable, ... }:
{

  home.packages = [
    pkgs.pavucontrol
    pkgs-stable.spotify
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.mpv
    pkgs.playerctl
  ];

  programs.obs-studio = {
    enable = true;
  };
}
