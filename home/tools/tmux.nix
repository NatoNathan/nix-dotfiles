{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];

    extraConfig = ''
      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      # bind c new-window -c "#{pane_current_path}"
    '';
  };
}
