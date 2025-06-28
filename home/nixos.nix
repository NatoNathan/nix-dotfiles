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
    prismlauncher
  ];

  imports = [
    ./environments/hyprland.nix
    ./misc/walker.nix
    ./misc/hyprpanel.nix
    ./misc/k8s.nix
    ./tools/utils.nix
    ./tools/networking.nix
    ./tools/git.nix
    ./tools/just.nix
    ./tools/ssh.nix
    ./tools/tmux.nix
    ./tools/starship.nix
    ./tools/direnv.nix
    ./media/spotify.nix
    ./media/tidal-hifi.nix
    ./media/mpv.nix
    ./media/obs.nix
    ./comms/discord.nix
    ./filemanagers/nnn.nix
    ./filemanagers/mc.nix
    ./editors/nvim.nix
    ./editors/vscode.nix
    ./editors/helix.nix
    ./editors/appflowy.nix
    ./editors/zed.nix
    ./shells/zsh.nix
    ./terminals/kitty.nix
    ./terminals/ghostty.nix
    ./browsers/firefox.nix
    ./browsers/google-chrome.nix
  ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
