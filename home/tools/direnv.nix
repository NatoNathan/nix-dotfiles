{ ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".config/direnv/lib" = {
    source = ./direnv/lib;
    executable = true;
    recursive = true;
  };
}
