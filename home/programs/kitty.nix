{ pkgs, ...}: {
    programs.kitty = {
        enable = true;
        settings = {
          font_family = "JetBrains Mono";
        };
    };
}