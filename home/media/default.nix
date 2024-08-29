{ pkgs, pkgs-stable, ...}:{

  home.packages = [
    pkgs.pavucontrol
    pkgs-stable.spotify
    pkgs.grim
    pkgs.watershot
  ];

  programs.obs-studio = {
    enable = true;
  };
}