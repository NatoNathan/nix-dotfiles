{ pkgs, config, ... }:
let
  zed-editor-config = "zed/settings.json";
in
{
  home.packages = with pkgs; [
    zed-editor
  ];

  # Zed editor configuration
  home.file."${config.xdg.configHome}/${zed-editor-config}".source = ./zed/settings.json;
}
