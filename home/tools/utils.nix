{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neofetch
    zip
    xz
    unzip
    p7zip
    tree
    nil
    nixfmt-rfc-style
    devenv
  ];

  programs.fzf = {
    enable = true;
  };

  programs.jq = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.btop = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

}
