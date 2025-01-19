{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  home.packages = with pkgs; [
    hyprpanel
  ];
  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_mocha";
    hyprland.enable = true;
    overlay.enable = true;
    settings = {
      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
      menus.dashboard.directories.enabled = false;
    };
  };
}
