{
  inputs,
  config,
  pkgs,
  hostname,
  username,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ../../modules/system.nix
    ../../modules/onepassword/darwin.nix
    ../../modules/environments/darwin.nix
  ];
  services.nix-daemon.enable = true;
  # Set Git commit hash for darwin-version.
  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";
}