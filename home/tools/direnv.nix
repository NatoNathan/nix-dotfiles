{ config, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file."${config.xdg.configHome}/direnv/lib" = {
    source = ./direnv/lib;
    executable = true;
    recursive = true;
  };
}
