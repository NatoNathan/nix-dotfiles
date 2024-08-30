{ lib, pkgs, ... }:
let
  _1passwordgui = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
in
{

  programs.git = {
    enable = true;
    userName = "NatoNathan";
    userEmail = "nathan@tamez.email";
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = _1passwordgui;
      };
      commit = {
        gpgsign = true;
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPABsK4J1z0fPJYGnJXtAXKEv2yDuub1OcfBaW3+Oitd";
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
