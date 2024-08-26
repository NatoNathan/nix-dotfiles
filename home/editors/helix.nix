{pkgs, ...}:{

  home.packages = with pkgs; [
    nixfmt # may move to home/tools/utils.nix
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai_pro_spectrum";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
  };
}