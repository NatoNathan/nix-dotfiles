{
  username,
  ...
}:
{
  home.username = username;

  imports = [
    ./tools/utils.nix
    ./tools/networking.nix
    ./tools/git.nix
    ./tools/just.nix
    ./tools/ssh.nix
    ./tools/tmux.nix
    ./tools/starship.nix
    ./tools/direnv.nix
    ./media/spotify.nix
    ./comms/discord.nix
    ./filemanagers/nnn.nix
    ./editors/nvim.nix
    ./editors/vscode.nix
    ./editors/helix.nix
    # ./editors/zed.nix
    ./shells/common.nix
    ./shells/zsh.nix
    ./terminals/kitty.nix
    ./terminals/alacritty.nix
    ./browsers/google-chrome.nix
  ];

  home.sessionVariables = {
    OP_SERVICE_ACCOUNT_TOKEN = "$(security find-generic-password -w -s 'onepassword' -a 'service-account')";
  };
  
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
