{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 13;
        normal = {
          family = "JetBrainsMono NF";
          style = "Regular";
        };
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };

        vi_mode_style = {
          shape = "Block";
          blinking = "On";
        };
      };
    };

  };
}
