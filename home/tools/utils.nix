{ pkgs, ... }:
{
  home.packages = with pkgs; [
    iotop
    neofetch
    zip
    xz
    unzip
    p7zip
    tree
    clipse
    nil
    nixfmt-rfc-style
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
