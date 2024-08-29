{ pkgs, pkgs-stable, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs-stable.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {};
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };
}