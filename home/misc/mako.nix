{ pkgs, lib, ... }:
{
  services.mako = {
    enable = true;
    
    settings = {
      # Appearance
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = lib.mkForce "#89b4fa";
      border-radius = 10;
      border-size = 2;
      
      # Position and size
      anchor = "top-right";
      margin = "20";
      padding = "15";
      width = 400;
      height = 150;
      
      # Behavior
      default-timeout = 5000;
      ignore-timeout = true;
      max-visible = 5;
      sort = "-time";
      
      # Font
      font = "JetBrainsMono Nerd Font 12";
      
      # Icons
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
      max-icon-size = 48;
      
      # Grouping
      group-by = "app-name";
    };
    
    # Extra configuration
    extraConfig = ''
      [urgency=low]
      border-color=#6c7086
      default-timeout=3000
      
      [urgency=normal]
      border-color=#89b4fa
      default-timeout=5000
      
      [urgency=critical]
      border-color=#f38ba8
      background-color=#f38ba8
      text-color=#181825
      default-timeout=0
      
      [app-name="Spotify"]
      border-color=#1db954
      
      [app-name="Discord"]
      border-color=#5865f2
    '';
  };
  
  # Add makoctl for notification control
  home.packages = with pkgs; [
    libnotify  # for notify-send
  ];
}