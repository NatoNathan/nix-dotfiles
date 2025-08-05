{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin = "10 20 0 20";
        spacing = 4;

        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/spotify" "tray" "network" "bluetooth" "wireplumber" "battery" "custom/power" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 50;
          separate-outputs = true;
        };

        clock = {
          timezone = "America/New_York";
          format = "{:%I:%M %p}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "  Connected";
          tooltip-format = "{ifname} via {gwaddr}";
          format-disconnected = "⚠  Disconnected";
          on-click = "nm-connection-editor";
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = " Muted";
          format-icons = ["" "" ""];
          on-click = "helvum";
          max-volume = 150;
          scroll-step = 0.2;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        "custom/spotify" = {
          format = "{icon} {}";
          escape = true;
          return-type = "json";
          max-length = 40;
          interval = 30;
          on-click = "playerctl -p spotify play-pause";
          on-click-right = "spotify";
          scroll-step = 1;
          on-scroll-up = "playerctl -p spotify next";
          on-scroll-down = "playerctl -p spotify previous";
          smooth-scrolling-threshold = 10.0;
          exec = "playerctl -p spotify -f '{\"text\": \"{{artist}} - {{title}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' metadata --follow";
          exec-if = "pgrep spotify";
          format-icons = {
            "Playing" = "";
            "Paused" = "";
            "Stopped" = "";
          };
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wlogout";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        color: #cdd6f4;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background: rgba(30, 30, 46, 0.8);
        border-radius: 15px;
        margin: 5px;
        padding: 0 10px;
      }

      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #6c7086;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.active {
        color: #cba6f7;
        border-bottom: 3px solid #cba6f7;
      }

      #workspaces button:hover {
        background: rgba(203, 166, 247, 0.2);
        color: #cba6f7;
      }

      #window {
        color: #fab387;
        font-weight: bold;
      }

      #clock {
        color: #89b4fa;
        font-weight: bold;
      }

      #network,
      #bluetooth,
      #wireplumber,
      #battery,
      #tray {
        padding: 0 10px;
        color: #a6e3a1;
      }

      #custom-spotify {
        padding: 0 10px;
        color: #1db954;
        font-weight: bold;
      }

      #custom-spotify.Playing {
        color: #1db954;
      }

      #custom-spotify.Paused {
        color: #6c7086;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #wireplumber.muted {
        color: #6c7086;
      }

      #battery.critical:not(.charging) {
        color: #f38ba8;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #181825;
        }
      }

      #custom-power {
        color: #f38ba8;
        font-size: 16px;
        padding: 0 10px;
      }

      #custom-power:hover {
        background: rgba(243, 139, 168, 0.2);
      }
    '';
  };
}
