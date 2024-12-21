{ inputs, pkgs, ... }:
{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
  home.packages = with pkgs; [
    grimblast
    gpu-screen-recorder
    matugen
    swww
    dart-sass
    brightnessctl
    hyprpicker
    python312Packages.gpustat
    hyprpanel
  ];
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {

      xwayland = {
        force_zero_scaling = true;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "us";

        follow_mouse = true;

        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
        };

      };
      gestures = {
        workspace_swipe = true;
      };

      # My Programs
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$stableBrowser" = "firefox";
      "$fileManager" = "kitty nnn";
      "$menu" = "walker";
      "$passwardManager" = "1password --quick-access";
      "$1passwordClient" = "1password --toggle";
      "$notification" = "hyprpanel -t notificationsmenu";
      "$dashboad" = "hyprpanel -t dashboardmenu";
      "$audio" = "hyprpanel -t audiomenu";
      "$email" = "protonmail-desktop";
      "$snapshot" = ''grim -g "$(slurp)" - | swappy -f -'';
      "$fullSnapshot" = ''grim -g "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"')" - | swappy -f -'';
      exec-once = [
        "lxqt-policykit-agent"
        "${pkgs.hyprpanel}/bin/hyprpanel"
        "1password --silent"
        "clipse -listen"
        "hyprctl setcursor Bibata-Modern-Ice 24"
      ];

      cursor = {
        "no_hardware_cursors" = true;
      };

      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

      bind =
        [
          # General
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, V, togglefloating,"

          # dwindle tiling
          "$mainMod, P, pseudo, dwindle"
          "$mainMod, J, togglesplit, dwindle"

          # Programs
          "$mainMod, P, exec, $terminal --class clipse -e 'clipse'"
          "$mainMod, Q, exec, $terminal"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, N, exec, $notification"
          "$mainMod, D, exec, $dashboad"
          "$mainMod, A, exec, $audio"
          "$mainMod, R, exec, $menu"
          "$mainMod, W, exec, $browser"
          "$mainMod SHIFT, W, exec, $browser --private-window"
          "$mainMod, F,  exec, $stableBrowser"
          "$mainMod SHIFT, F, exec, $stableBrowser -private-window"
          "Control_L SHIFT, SPACE, exec, $passwardManager"
          "$mainMod SHIFT, SPACE, exec, $1passwordClient"
          "$mainMod, T, exec, $email"
          ", Print, exec, $fullSnapshot"
          "$mainMod, Print, exec, $snapshot"

          # Focus
          "$mainMod, left, moveFocus, l"
          "$mainMod, right, moveFocus, r"
          "$mainMod, up, moveFocus, u"
          "$mainMod, down, moveFocus, d"
          "$mainMod, Tab, cycleNext"

          # Move Windows
          "$mainMod SHIFT, left, moveWindow, l"
          "$mainMod SHIFT, right, moveWindow, r"
          "$mainMod SHIFT, up, moveWindow, u"
          "$mainMod SHIFT, down, moveWindow, d"

          "$mainMod SHIFT, Space, centerwindow"

          # Special Workspaces
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Workspaces
          # Next workspace
          "$mainMod ALT_L, Tab, workspace, m+1"
          # Previous workspace
          "$mainMod ALT_L SHIFT, Tab, workspace, m-1"

        ]
        ++ (
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );

      bindm = [
        # Move/Resize Windows
        "$mainMod, mouse:272, movewindow" # 272 is the left mouse button
        "$mainMod, Control_L, movewindow" # 272 is the left mouse button
        "$mainMod, mouse:273, resizewindow" # 273 is the right mouse button
        "$mainMod, ALT_L, resizewindow" # 273 is the right mouse button
      ];

      bindel = [
        # Audio
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        # Brightness
        ", XF86MonBrightnessUp, exec, brightnessctl -s set +5%" # Increase brightness by 5%
        ", XF86MonBrightnessDown, exec, brightnessctl -s set 5%-" # Decrease brightness by 5%
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      # Window rules
      # Float polkit dialogs
      # windowrulev2 = float, title:^(Authentication Required)$
      # windowrulev2 = center,title:^(Authentication Required)$
      # windowrulev2 = size 400 200,title:^(PolicykitAuthentication RequiredAgentGUI)$

      # # Example windowrule v2
      # # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
      windowrulev2 = [
        # Float, center, and resize polkit dialogs
        "float, title:^(Authentication Required)$"
        "center,title:^(Authentication Required)$"
        "size 400 200,title:^(PolicykitAuthentication RequiredAgentGUI)$"

        # Float and center 1Password dialogs
        "float, title:^(Unlock 1Password)$"
        "center,title:^(Unlock 1Password)$"

        # Float, center, and resize Clipse
        "float, title:^(Clipse)$"
        "center,title:^(Clipse)$"
        "size 622 652,title:^(Clipse)$"

        # Float, center, and full screen swappy
        "float, title:^(Swappy)$"
        "center,title:^(Swappy)$"
        "fullscreen,title:^(Swappy)$"

        # Ignore maximize events
        "suppressevent maximize, class:.*"
      ];
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    # Set the cursor theme  
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
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Environment Variables for Hyprland
  home.sessionVariables = {
    GDK_SCALE = "2";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    OP_SERVICE_ACCOUNT_TOKEN = "$(secret-tool lookup service-account-token one-password)";
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

  

  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ./hyprlock.conf;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";         # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";                 # monitor backlight restore.
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 350;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
