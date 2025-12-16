{ pkgs, ... }:
{
  # Comprehensive graphics support including Vulkan
  hardware.graphics = {
    enable32Bit = true;  
    extraPackages = with pkgs; [
      # Vulkan packages
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-loader
    ];
  };

  # Add vulkan tools for debugging
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-headers
  ];
}