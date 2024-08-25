{ pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
    settings = {
      monitor = [
        "DP-1, 2560x2880@59.96, -1930x0, 1.3333333"
        "DP-2, 2560x1440@164.96, 0x400, 1"
      ];

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

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

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
      };


      # My Programs
      "$terminal" = "kitty";
      "$browser" = "firefox";
      "$fileManager" = "kitty nnn";
      "$menu" = "wofi --show drun";
      "$notificationCenter" = "swaync";
      "$notificationCenterClient" = "swaync-client -t -sw";
      "$passwardManager" = "1password --quick-access";
      "$1passwordClient" = "1password --toggle";
      "$bar" = "ags";

      exec-once = [
        "$notificationCenter"
        "lxqt-policykit-agent"
        "$bar"
        "1password --silent"
      ];

      cursor = {
        "no_hardware_cursors" = true;
      };

      "$mainMod" = "SUPER";# Sets "Windows" key as main modifier

      bind = [
        # General
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"

        # dwindle tiling
        "$mainMod, P, pseudo, dwindle"
        "$mainMod, J, togglesplit, dwindle"
        
        # Programs
        "$mainMod, Q, exec, $terminal"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, R, exec, $menu"
        "$mainMod, N, exec, $notificationCenterClient"
        "$mainMod, W, exec, $browser"
        "$mainMod SHIFT, W, exec, $browser -private-window"
        "Control_L SHIFT, SPACE, exec, $passwardManager"
        "$mainMod SHIFT, SPACE, exec, $1passwordClient"

        # Focus
        "$mainMod, left, moveFocus, l"
        "$mainMod, H, moveFocus, l" # h is alias for left in vim
        "$mainMod, right, moveFocus, r"
        "$mainMod, L, moveFocus, r" # l is alias for right in vim
        "$mainMod, up, moveFocus, u"
        "$mainMod, k, moveFocus, u" # k is alias for up in vim
        "$mainMod, down, moveFocus, d"
        "$mainMod, J, moveFocus, d" # j is alias for down in vim

        # Special Workspaces
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

      bindm = [
        # Move/Resize Windows
        "$mainMod, mouse:272, movewindow" # 272 is the left mouse button
        "$mainMod, mouse:273, resizewindow" # 273 is the right mouse button
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

        # Ignore maximize events
        "suppressevent maximize, class:.*"
      ];
    };
  };

  # Environment Variables for Hyprland
  home.sessionVariables = {
    GDK_SCALE= "2";
    XCURSOR_SIZE= "32";
    HYPRCURSOR_SIZE= "24";
    LIBVA_DRIVER_NAME= "nvidia";
    XDG_SESSION_TYPE= "wayland";
    GBX_BACKEND= "nvidia-drm";
    GLX_VENDOR_LIBRARY_NAME= "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT= "auto";
    NIXOS_OZONE_WL= "1";
  };
}