{ inputs, pkgs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];
  
  home.packages = with pkgs; [
    # Screenshots and screen recording
    grimblast
    grim
    slurp
    swappy
    gpu-screen-recorder
    
    # Utilities for COSMIC
    brightnessctl
    wl-clipboard
    clipse  # Clipboard manager
    python312Packages.gpustat
    
    # Terminal emulator
    ghostty
  ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  # dconf for COSMIC and GTK applications
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      # COSMIC-specific dconf settings can be added here
      "com/system76/CosmicComp" = {
        # COSMIC compositor settings
      };
    };
  };

  # GTK theming (still needed for GTK apps in COSMIC)
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Qt theming
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Environment Variables for COSMIC
  home.sessionVariables = {
    GDK_SCALE = "2";
    XCURSOR_SIZE = "24";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    COSMIC_DATA_CONTROL_ENABLED = "1";
    OP_SERVICE_ACCOUNT_TOKEN = "$(secret-tool lookup service-account-token one-password)";
    TERM = "ghostty";
  };

  # Gnome Keyring (COSMIC uses it for credential storage)
  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
      "pkcs11"
      "ssh"
    ];
  };

  # COSMIC-specific configuration
  # Note: Most COSMIC configuration is done through the COSMIC settings app
  # This file mainly handles environment setup and integration with other tools
  
  # Configure applications to work well with COSMIC
  programs = {
    # Configure terminal to work with COSMIC
    ghostty = {
      enable = true;
      # COSMIC-specific ghostty settings can be added here
    };
  };
}