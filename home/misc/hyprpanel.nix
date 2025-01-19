{ inputs, ... }:
{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    theme = "catppuccin_mocha";
    hyprland.enable = true;

    settings = {
      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
      menus.dashboard.directories.enabled = false;
    };
  };
}
