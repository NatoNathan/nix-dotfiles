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
        modules-center = [ "mpris" ];
        modules-right = [ "tray" "network" "bluetooth" "wireplumber" "battery" "clock" "custom/power" ];

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
          format-wifi = "󰖩";
          format-ethernet = "󰈀";
          tooltip-format-wifi = "Interface: {ifname}\nSSID: {essid}\nSignal: {signalStrength}% ({frequency} MHz)\nIPv4: {ipaddr}/{cidr}\nIPv6: {ipaddr6}\nGateway: {gwaddr}\nBandwidth: ↓{bandwidthDownBytes} ↑{bandwidthUpBytes}\nNetmask: {netmask}";
          tooltip-format-ethernet = "Interface: {ifname}\nIPv4: {ipaddr}/{cidr}\nIPv6: {ipaddr6}\nGateway: {gwaddr}\nBandwidth: ↓{bandwidthDownBytes} ↑{bandwidthUpBytes}\nNetmask: {netmask}";
          format-disconnected = "󰌙";
          tooltip-format-disconnected = "Network disconnected";
          on-click = "nm-connection-editor";
        };

        bluetooth = {
          format = "󰂯";
          format-connected = "󰂱";
          format-disabled = "󰂲";
          tooltip-format = "Controller: {controller_alias}\nAddress: {controller_address}\nStatus: {status}\nConnections: {num_connections}";
          tooltip-format-connected = "Controller: {controller_alias}\nAddress: {controller_address}\nConnections: {num_connections}\n\nDevices:\n{device_enumerate}";
          tooltip-format-enumerate-connected = "• {device_alias} ({device_address})";
          tooltip-format-enumerate-connected-battery = "• {device_alias} ({device_address}) - {device_battery_percentage}%";
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

        mpris = {
          format = "{player_icon}";
          format-paused = "{status_icon}";
          player-icons = {
            "default" = "󰎆";
            "spotify" = "󰓇";
            "firefox" = "󰈹";
            "chrome" = "󰊯";
          };
          status-icons = {
            "playing" = "󰐊";
            "paused" = "󰏤";
            "stopped" = "󰓛";
          };
          tooltip-format = "{player}: {artist} - {title}";
          tooltip-format-stopped = "No media playing";
          max-length = 40;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl stop";
          on-scroll-up = "playerctl next";
          on-scroll-down = "playerctl previous";
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

      #mpris {
        padding: 0 10px;
        color: #1db954;
        font-weight: bold;
      }

      #mpris.playing {
        color: #1db954;
      }

      #mpris.paused {
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
