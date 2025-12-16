{ lib, pkgs, ... }:
let
  op-ssh-sign = {
    x86_64-linux = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
    x86_64-darwin = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  };
  _1passwordgui = op-ssh-sign.${pkgs.stdenv.hostPlatform.system};
in
{

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "NatoNathan";
        email = "nathan@tamez.email";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPABsK4J1z0fPJYGnJXtAXKEv2yDuub1OcfBaW3+Oitd";
      };
      push = {
        autoSetupRemote = true;
      };
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = _1passwordgui;
      };
      commit = {
        gpgsign = true;
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
