{
  username,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

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
    ./media
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
