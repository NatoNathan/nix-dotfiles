{ inputs, pkgs, ...}:{
 imports = [ inputs.ags.homeManagerModules.default ];

 programs.ags = {
  enable = true;

  configDir = ../configs/ags;

  extraPackages = with pkgs; [];
 };
}