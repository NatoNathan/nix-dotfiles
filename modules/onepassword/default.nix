{ lib, pkgs, config, ... }: {
  imports = [] ++ [
    lib.mkIf (pkgs.stdenv.hostPlatform.system == "x86_64-linux" ) ./linux.nix
    lib.mkIf (pkgs.stdenv.hostPlatform.system == "x86_64-darwin") ./darwin.nix
  ];
}