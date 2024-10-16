{
  pkgs,
  username,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    clipse
    pavucontrol
    grim
    slurp
    swappy
    playerctl
    iotop
    protonmail-desktop
  ];

  imports = [
    ./environments/hyprland.nix
    ./misc/anyrun.nix
    ./tools/utils.nix
    ./tools/networking.nix
    ./tools/git.nix
    ./tools/just.nix
    ./tools/ssh.nix
    ./tools/tmux.nix
    ./tools/starship.nix
    ./tools/direnv.nix
    ./media
    ./media/mpv.nix
    ./media/obs.nix
    ./comms/discord.nix
    ./filemanagers/nnn.nix
    ./editors/nvim.nix
    ./editors/vscode.nix
    ./editors/helix.nix
    ./editors/zed.nix
    ./shells/zsh.nix
    ./terminals/kitty.nix
    ./browsers/firefox.nix
  ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
