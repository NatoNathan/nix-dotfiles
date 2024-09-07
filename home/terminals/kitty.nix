{ pkgs, ... }:
{
  programs.kitty = {
    package = pkgs.kitty;
    enable = true;
    settings = {
      font_family = "JetBrainsMono NF";
    };
  };
}
