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
    
    # Theming and utilities
    matugen
    swww
    dart-sass
    brightnessctl
    
    # Niri-specific utilities
    fuzzel  # Application launcher
    mako    # Notification daemon
    waybar  # Status bar
    clipse  # Clipboard manager
    
    # Color picker
    hyprpicker
    python312Packages.gpustat
  ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  # Niri window manager configuration
  programs.niri = {
    enable = true;
    settings = {
      # Input configuration
      input = {
        keyboard = {
          layout = "us";
        };
        
        touchpad = {
          natural-scroll = true;
          click-method = "clickfinger";
          scroll-factor = 0.5;
        };
        
        mouse = {
          sensitivity = 0.0;
        };
      };

      # Layout settings
      layout = {
        gaps = 16;
        center-focused-column = "never";
        default-column-width = {
          proportion = 0.5;
        };
        preset-column-widths = [
          { proportion = 1.0; }
          { proportion = 0.5; }
          { proportion = 0.33; }
          { proportion = 0.67; }
        ];
      };

      # Window rules
      window-rules = [
        {
          matches = [{ app-id = "1password"; }];
          default-column-width = { fixed = 400; };
        }
        {
          matches = [{ title = "Clipse"; }];
          default-column-width = { fixed = 622; };
        }
        {
          matches = [{ title = "Swappy"; }];
          open-fullscreen = true;
        }
      ];

      # Keybindings
      binds = with pkgs; {
        # General
        "Mod+Shift+BackSpace".action.quit = {};
        "Mod+Q".action.spawn = ["ghostty"];
        "Mod+Shift+Q".action.close-window = {};

        # Applications
        "Mod+R".action.spawn = ["fuzzel"];
        "Mod+E".action.spawn = ["kitty" "nnn"];
        "Mod+W".action.spawn = ["firefox"];
        "Mod+Shift+W".action.spawn = ["firefox" "--private-window"];
        "Mod+T".action.spawn = ["protonmail-desktop"];
        "Mod+A".action.spawn = ["pavucontrol"];
        
        # Password manager
        "Ctrl+Shift+Space".action.spawn = ["1password" "--quick-access"];
        "Mod+Shift+Space".action.spawn = ["1password" "--toggle"];
        
        # Clipboard
        "Mod+P".action.spawn = ["ghostty" "--class" "clipse" "-e" "clipse"];
        
        # Screenshots (Mac-style)
        "Mod+Shift+3".action.spawn = ["sh" "-c" ''grim -g "$(niri msg -j outputs | jq -r '.[] | select(.focused) | \"\\(.logical.x),\\(.logical.y) \\(.logical.width)x\\(.logical.height)\"')" - | swappy -f -''];
        "Mod+Shift+4".action.spawn = ["sh" "-c" ''grim -g "$(slurp)" - | swappy -f -''];
        "Mod+Shift+5".action.spawn = ["grimblast" "--notify" "copysave" "area"];
        
        # Window management
        "Mod+Left".action.focus-column-left = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Down".action.focus-window-down = {};
        
        "Mod+Shift+Left".action.move-column-left = {};
        "Mod+Shift+Right".action.move-column-right = {};
        "Mod+Shift+Up".action.move-window-up = {};
        "Mod+Shift+Down".action.move-window-down = {};
        
        # Workspaces
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 10;
        
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Shift+0".action.move-column-to-workspace = 10;
        
        # Audio controls
        "XF86AudioRaiseVolume".action.spawn = ["swayosd-client" "--output-volume" "raise"];
        "XF86AudioLowerVolume".action.spawn = ["swayosd-client" "--output-volume" "lower"];
        "XF86AudioMute".action.spawn = ["swayosd-client" "--output-volume" "mute-toggle"];
        
        # Brightness controls
        "XF86MonBrightnessUp".action.spawn = ["swayosd-client" "--brightness" "raise"];
        "XF86MonBrightnessDown".action.spawn = ["swayosd-client" "--brightness" "lower"];
      };

      # Startup programs
      spawn-at-startup = [
        { command = ["1password" "--silent"]; }
        { command = ["clipse" "-listen"]; }
        { command = ["waybar"]; }
        { command = ["mako"]; }
        { command = ["swayosd-server"]; }
        { command = ["vicinae" "server"]; }
      ];

      # Environment
      environment = {
        NIXOS_OZONE_WL = "1";
        TERM = "ghostty";
      };
    };
  };

  # dconf for GTK applications
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  # GTK theming
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

  # Environment Variables for Niri
  home.sessionVariables = {
    GDK_SCALE = "2";
    XCURSOR_SIZE = "24";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    OP_SERVICE_ACCOUNT_TOKEN = "$(secret-tool lookup service-account-token one-password)";
    TERM = "ghostty";
  };

  # Gnome Keyring
  services.gnome-keyring = {
    enable = true;
    components = [
      "secrets"
      "pkcs11"
      "ssh"
    ];
  };
}