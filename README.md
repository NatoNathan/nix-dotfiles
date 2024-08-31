# Nat's Nix dotfile's

Hey, you have stubled across my dotfiles, not much here really, just a nix flake that setup my systems.

## What's included

```json
{
    "Operating System": "NixOs",
    "Window Manager": "hyprland",
    "Terminal Emulator": "kitty",
    "Shell": "zsh",
    "editor": ["neovim", "vscode", "zed", "helix"],
    "browser": ["firefox", "zen-browser"],
    "Music Player": "spotify",
    "Video Player": null, // for now
    "File Manager": "nnn",
    "Launcher": "anyrun", // for now
    "Status Bar": "hyprPanel",
    "Notification Daemon": "hyprPanel",
    "Fonts": ["JetBrains Mono Nerd Font", "Fira Code Nerd Font"],
    "other": ["starship", "1password", "liquidctl"]
}
```

## Usage

Not sure why you would want to be a copycat, this is my opinionated setup you may not like like my choices, especially my choice to use [hyprland](https://hyprland.org/) as my window manager, but hey, you do you.

::warning Word of warning, this is very much a personal setup, and this setup contains configuration for my hardware, such as my graphics card. You may need to adjust the configuration to suit your hardware.

First off you'll need to to install NixOs (i have yet to setup nix-darwin or nix on other distros) and then you can follow the steps below.

1. Clone the repo

```bash
git clone github:NatoNathan/nix-dotfiles ~/.dotfiles
cd ~/.dotfiles
```

2. Make your hosts directory (or modify one of the existing ones)

```bash
mkdir hosts/{your-hostname} # Replace {your-hostname} with your hostname
```

3. Copy the configuration.nix file

```bash
cp hosts/natt-home-pc/configuration.nix hosts/{your-hostname}/configuration.nix
```

4. Backup your current configuration

```bash
mv /etc/nixos/ /etc/nixos.bak
```

5. Symlink the flake to `/etc/nixos/`

```bash
sudo ln -s ~/.dotfiles /etc/nixos
```

6. Copy hardware specific configuration from your current system (Important)

```bash
cp /etc/nixos.bak/hardware-configuration.nix .dotfiles/hosts/{your-hostname}/hardware-configuration.nix
```

7. Edit the hostname and username in `./flake.nix`

```nix
nixosConfigurations = {
        natt-home-pc =
          let
            username = "YOUR_USERNAME";
            hostname = "YOUR_HOSTNAME"; # Replace with your hostname used in the previous steps
            specialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
              inherit pkgs-stable;
              inherit pkgs;
            };
          in
          nixpkgs.lib.nixosSystem {...}
```

8. Update the flake registry (optional but recommended)

```bash
nix flake update
```

9. Build the system, this will take a while

:warning: This may take a while, especially if you have a slow internet connection or a slow computer

```bash
sudo nixos-rebuild switch --flake .#{your-hostname}
```

:note the `--flake` flag is optional as we have symlinked the flake to `/etc/nixos/` 
but is needed if your changing the hostname of the system

10. Reboot (optional, but recommended)

```bash
reboot
```

Enjoy your new system, configured by me, for me, but now for you.

11. If you don't some thing, you can always change it, just fork the repo and make your changes.

12. If you have a better way of doing something, please let me know by opening an issue or a pull request. I'm always looking to improve my setup.
