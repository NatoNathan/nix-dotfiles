# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal NixOS dotfiles repository using Nix Flakes for declarative system configuration management. It supports multiple systems including NixOS desktops/laptops and macOS through nix-darwin. The configuration uses home-manager for user-specific settings and includes a Hyprland-based desktop environment.

## System Management Commands

### Building and Switching Configurations

For NixOS systems:
```bash
# Build and switch to new configuration (from repo root)
sudo nixos-rebuild switch --flake .#<hostname>

# Available hostnames: natt-home-pc, natt-framework-laptop
sudo nixos-rebuild switch --flake .#natt-home-pc

# Test configuration without switching
sudo nixos-rebuild test --flake .#<hostname>

# Build without switching
sudo nixos-rebuild build --flake .#<hostname>
```

For macOS systems:
```bash
# Build and switch Darwin configuration
darwin-rebuild switch --flake .#natt-macbook-pro
```

### Flake Management

```bash
# Update all flake inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Show flake info
nix flake show

# Check flake for errors
nix flake check
```

### Garbage Collection

```bash
# Clean up old generations and garbage collect
sudo nix-collect-garbage -d

# For home-manager
home-manager expire-generations "-30 days"
```

## Architecture

### Directory Structure

- `flake.nix` - Main flake configuration defining system outputs
- `hosts/` - Host-specific configurations
  - `natt-home-pc/` - Desktop system with NVIDIA GPU
  - `natt-framework-laptop/` - Framework laptop configuration  
  - `natt-macbook-pro/` - macOS system configuration
- `modules/` - System-level NixOS modules
- `home/` - Home-manager configuration modules organized by category

### Configuration Layers

1. **Flake Level** (`flake.nix`): Defines system configurations and manages inputs
2. **Host Level** (`hosts/<hostname>/default.nix`): Host-specific system configuration
3. **Module Level** (`modules/*.nix`): Reusable system-level modules
4. **Home Level** (`home/*.nix`): User-space configuration via home-manager

### Key Modules

- `modules/system.nix` - Core system settings, fonts, and base packages
- `modules/hyprland.nix` - Hyprland window manager configuration
- `modules/environments/nixos.nix` - NixOS-specific environment setup
- `home/nixos.nix` - Base home-manager configuration for NixOS
- `home/environments/hyprland.nix` - Hyprland user configuration

### Home Manager Structure

Home configuration is organized by application category:
- `browsers/` - Firefox, Chrome configurations
- `editors/` - Neovim, VSCode, Helix, Zed
- `terminals/` - Kitty, Ghostty, Alacritty
- `tools/` - Git, SSH, Tmux, utilities
- `media/` - Spotify, MPV, OBS
- `shells/` - Zsh configuration

## Hardware-Specific Considerations

### NVIDIA Configuration (natt-home-pc)
- Uses stable NVIDIA drivers with custom settings in host configuration
- Requires specific environment variables for Wayland compatibility
- Monitor configuration is set per-host in home.nix

### Framework Laptop (natt-framework-laptop)
- Uses nixos-hardware module for Framework Intel Core Ultra Series 1
- Different hardware-configuration.nix compared to desktop

## Development Workflow

When making changes:

1. Edit configuration files in appropriate location
2. Test configuration: `sudo nixos-rebuild test --flake .#<hostname>`
3. If working correctly: `sudo nixos-rebuild switch --flake .#<hostname>`
4. Commit changes to git

For new hosts:
1. Create new directory in `hosts/`
2. Copy hardware-configuration.nix from `/etc/nixos/`
3. Create default.nix and home.nix based on existing hosts
4. Add configuration to flake.nix outputs

## Multiple System Support

The flake supports both NixOS and Darwin systems:
- NixOS systems use `nixosConfigurations`
- macOS systems use `darwinConfigurations`
- Different package sets available: `pkgs`, `pkgs-stable`, `pkgs-21ef15c`
- Home-manager integrated for both platforms with platform-specific modules