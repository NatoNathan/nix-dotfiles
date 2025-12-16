{ pkgs, ... }:
{
  # Enable nix-ld for development tool compatibility
  # Uses Steam's comprehensive library set for maximum compatibility
  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };
}