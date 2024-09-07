{ lib, pkgs, config, ... }: {
  imports = [] ++ [
    lib.mkIf (pkgs.system == "x86_64-linux" ) ./linux.nix
    lib.mkIf (pkgs.system == "x86_64-darwin") ./darwin.nix
  ];
}