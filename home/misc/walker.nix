{ pkgs, ... }: {
  home.packages = [
    pkgs.walker
  ];

  # Walker configuration via config files
  xdg.configFile."walker/config.json".text = builtins.toJSON {
    search.placeholder = "Search";
    ui = {
      fullscreen = false;
      anchors = {
        left = false;
        right = false;
        top = true;
        bottom = false;
      };
      window = {
        width = 600;
        height = 400;
      };
    };
    list = {
      height = 200;
    };
    websearch = {
      prefix = "";
    };
    switcher = {
      prefix = "/";
    };
  };

  xdg.configFile."walker/style.css".text = ''
    * {
      color: @theme_text_color;
    }

    #window {
      background-color: rgba(30, 30, 46, 0.95);
      border-radius: 16px;
      border: 2px solid rgba(203, 166, 247, 0.3);
      padding: 10px;
    }

    #input {
      background-color: rgba(49, 50, 68, 0.8);
      border: 1px solid rgba(116, 199, 236, 0.5);
      border-radius: 8px;
      padding: 8px 12px;
      font-size: 14px;
      color: #cdd6f4;
    }

    #list {
      background-color: transparent;
      margin-top: 8px;
    }

    .item {
      background-color: transparent;
      border-radius: 8px;
      padding: 8px 12px;
      margin: 2px 0;
    }

    .item:selected {
      background-color: rgba(203, 166, 247, 0.3);
    }

    .item:hover {
      background-color: rgba(203, 166, 247, 0.2);
    }

    .label {
      color: #cdd6f4;
      font-weight: normal;
    }

    .sub {
      color: #6c7086;
      font-size: 12px;
    }
  '';
}