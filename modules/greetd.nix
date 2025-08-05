{ inputs, pkgs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  hyprlandWaylandSessions = "${hyprland}/share/wayland-sessions";

  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --sessions ${hyprlandWaylandSessions}";
        user = "greeter";
      };
    };
  };

  boot.kernelParams = [ "console=tty1" ];
}
