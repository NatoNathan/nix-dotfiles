{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpris ];
      };
    })
  ];
  home.packages = [
    pkgs.mpv
  ];
}
