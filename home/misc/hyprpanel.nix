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
    overwrite.enable = true;
    settings = {
      theme.font = {
        name = "departureMono Nerd Font";
        size = "16px";
      };
      bar.launcher.autoDetectIcon = true;
      menus.dashboard.directories.enabled = false;
    };
  };
}
