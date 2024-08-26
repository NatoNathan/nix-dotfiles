{pkgs, ...}: {

  home.packages = with pkgs; [
    pavucontrol
  ];

  programs.obs-studio = {
    enable = true;
  };
}