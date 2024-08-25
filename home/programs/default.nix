{pkgs, ...}: {
  imports = [
    ./ags.nix
    ./firefox.nix
    ./git.nix
    ./kitty.nix
    ./ssh.nix
    ./tmux.nix
    ./vscode.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    
    # File Managers
    nnn

    # Archives
    zip
    xz
    unzip
    p7zip

    # Comunications
    discord

    # Utils
    jq
    fzf
    ripgrep

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    iftop 

    # Misc
    neofetch
    btop
    iotop

    wofi
    pavucontrol
    just
];
}