{ inputs, pkgs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  hyprlandWaylandSessions = "${hyprland}/share/wayland-sessions";
  
  # Standard system wayland sessions
  systemWaylandSessions = "/run/current-system/sw/share/wayland-sessions";

  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  
  # Combine session directories for tuigreet
  sessionDirs = "${hyprlandWaylandSessions}:${systemWaylandSessions}";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${sessionDirs}";
        user = "greeter";
      };
    };
  };

  boot.kernelParams = [ "console=tty1" ];
}
