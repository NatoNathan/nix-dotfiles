# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  pkgs-21ef15c,
  hostname,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/environments/nixos.nix
    ../../modules/graphics.nix
    ../../modules/nix-ld.nix
    ../../modules/hyprland.nix
    ../../modules/niri.nix
    ../../modules/cosmic.nix
    ../../modules/greetd.nix
    ../../modules/onepassword/linux.nix
    ../../modules/docker.nix
    ../../modules/flatpak.nix
    ../../modules/steam.nix
    ../../modules/keyd.nix
    ../../modules/tailscale.nix
    ../../modules/ollama
    ../../modules/zed.nix
  ];

  # Bootloader configuration
  boot = {

    # boot drive encryption with LUKS stuff
    initrd.luks.devices."luks-cdc58934-a09a-4113-8e51-7450c0452869".device = "/dev/disk/by-uuid/cdc58934-a09a-4113-8e51-7450c0452869";

    # Use systemd-boot rather than GRUB
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Play with the kernel for compatibility with framework 13
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      '''"acpi_osi=!Windows 2020"''
    ];
  };

  # enable a type of swap ram disk
  zramSwap.enable = true;
  # enable fingerprint reader
  services.fprintd.enable = true;


  # battery management stuff
  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  fileSystems."/mnt/homenas/media" = {
    fsType = "nfs";
    device = "192.168.1.72:/volume1/Media";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  services.logind.settings.Login = {
    # map the power button to suspend
    HandlePowerKey = "suspend";
    # map long power button press to power off
    HandleSuspendKey = "poweroff";
  };

  services.fwupd = {
    enable = true;

    # use a specific version of fwupd, not needed normally
    # package = pkgs-21ef15c.fwupd;
  };

  # Network configuration
  networking.hostName = hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
  # Enable the Intel video driver
  services.xserver.videoDrivers = [ "intel" ];

  # Enable Blueman
  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  # Bluetooth 
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Desktop Environment Configuration
  # Enable/disable different window managers/desktop environments
  # Only one should typically be enabled at a time
  niri.enable = false;      # Scrollable-tiling Wayland compositor
  cosmic.enable = false;    # System76 COSMIC desktop environment

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
