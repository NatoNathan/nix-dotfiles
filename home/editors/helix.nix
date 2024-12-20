{ pkgs, lib, ... }:
{

  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkDefault "monokai_pro_spectrum";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
  };
}
