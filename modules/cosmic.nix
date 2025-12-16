{ inputs, pkgs, lib, config, ... }:
{
  options = {
    cosmic.enable = lib.mkEnableOption "COSMIC desktop environment";
  };

  config = lib.mkIf config.cosmic.enable {
    # Enable COSMIC desktop environment
    services.desktopManager.cosmic.enable = true;
    
    # Enable COSMIC greeter (optional - can be disabled if keeping tuigreet)
    services.displayManager.cosmic-greeter.enable = false;

    # Environment variables for COSMIC
    environment.sessionVariables = {
      COSMIC_DATA_CONTROL_ENABLED = "1";
      NIXOS_OZONE_WL = "1";
    };

    # Nvidia compatibility settings if using nvidia drivers
    boot.kernelParams = lib.mkIf config.services.xserver.videoDrivers == ["nvidia"] [
      "nvidia_drm.fbdev=1"
    ];

    # Required packages for COSMIC
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];

    # Audio support (if not already enabled)
    services.pipewire.enable = lib.mkDefault true;

    # Optional: Enable Flatpak for additional app support
    services.flatpak.enable = lib.mkDefault false;
  };
}