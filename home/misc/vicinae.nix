{ pkgs, ... }: {
  home.packages = [
    pkgs.vicinae
  ];

  # Vicinae configuration
  xdg.configFile."vicinae/config.json".text = builtins.toJSON {
    theme = "dark";
    extensions = {
      calculator = {
        enabled = true;
      };
      clipboard = {
        enabled = true;
      };
      emoji = {
        enabled = true;
      };
      files = {
        enabled = true;
        searchPaths = [
          "$HOME"
          "$HOME/Documents"
          "$HOME/Downloads"
          "$HOME/Projects"
        ];
      };
    };
    ui = {
      width = 600;
      height = 400;
      borderRadius = 12;
      showIcons = true;
    };
  };
}