{ pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {};
  };

  home.sessionVariables = {
    BROWSER = "firefox";
  };
}