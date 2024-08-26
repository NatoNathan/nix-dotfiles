{ pkgs, ... }: {
  home.packages = with pkgs; [
    iotop
    neofetch
    zip
    xz
    unzip
    p7zip

    wofi
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

  
}