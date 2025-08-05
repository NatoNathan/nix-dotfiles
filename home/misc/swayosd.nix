{ pkgs, config, ... }:
let
  swayosdStyle = pkgs.writeText "swayosd.css" ''
    window {
      background: rgba(30, 30, 46, 0.9);
      border-radius: 15px;
      border: 2px solid #89b4fa;
      color: #cdd6f4;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
      padding: 20px;
    }
    
    progressbar {
      background: #313244;
      border-radius: 10px;
      min-height: 10px;
    }
    
    progressbar progress {
      background: linear-gradient(90deg, #89b4fa, #cba6f7);
      border-radius: 10px;
      min-height: 10px;
    }
    
    .osd_volume .icon {
      color: #a6e3a1;
      font-size: 32px;
    }
    
    .osd_brightness .icon {
      color: #f9e2af;
      font-size: 32px;
    }
    
    .osd_caps_lock .icon {
      color: #fab387;
      font-size: 32px;
    }
  '';
in
{
  services.swayosd = {
    enable = true;
    display = ":0";
    stylePath = swayosdStyle;
    topMargin = 0.9;
  };
  
  # Add swayosd package for manual control if needed
  home.packages = with pkgs; [
    swayosd
  ];
}