{config, pkgs, username, ...} : 
{
    home.username = username;
    home.homeDirectory = "/home/${username}";

    imports = [
        ./programs
        ./environments/hyprland.nix
    ];
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}