{ inputs, pkgs, ... }:
let
  anyrun_plugins = inputs.anyrun.packages.${pkgs.system};
in
{
  imports = [ inputs.anyrun.homeManagerModules.default ];
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with anyrun_plugins; [
        applications
        rink
        shell
        websearch
        # "anyrun-plugin-bar"
      ];
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      width = {
        fraction = 0.3;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "top";
    };

    extraCss = ''
      window {
        # Hide background
        background-color: rgba(0, 0, 0, 0);
      }
    '';
  };
}
