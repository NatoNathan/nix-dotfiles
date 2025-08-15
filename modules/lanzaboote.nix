{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Enable Lanzaboote now that keys are created
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}