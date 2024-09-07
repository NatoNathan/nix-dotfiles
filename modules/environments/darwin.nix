{ username, ... }: {
  homebrew = {
    enable = true;

    taps = [
      {
        name="zen-browser/browser";
        clone_target="https://github.com/zen-browser/desktop.git";
      }
    ];
    brews = [
      "rustup"
      "fnm"
    ];
    casks = [
      { name= "zen-browser"; greedy = true; }
      { name= "arc"; greedy = true; }
      "marta"
      "alfred"
    ];
    onActivation.cleanup = "zap";
  };

  # system.activationScripts."rustup-init" = {
  #   enable = true;
  #   text = ''
  #   if ! command -v cargo &> /dev/null
  #   then
  #       echo "rustup could not be found, installing from hombrew"
  #       rustup-init -y
  #   else
  #       echo "rustup is already installed"
  #   fi
  #   '';
  # };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  security.pam.enableSudoTouchIdAuth = true;

  users.users.${username}.home = "/Users/${username}";
}