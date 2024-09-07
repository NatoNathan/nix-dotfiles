default: deploy

os := `uname -s`
# the nix rebuild command for the system i.e. nixos (nixos-rebuild), darwin (darwin-rebuild)
nix-rebuild :=  if os == "Darwin" {
    "darwin-rebuild switch"
} else if `grep -q 'ID=nixos' /etc/os-release && echo "nixos" || echo "not-nixos"` == "nixos" {
    "nixos-rebuild switch --use-remote-sudo"
} else {
    error("OS is not supported")
}

deploy:
    {{ nix-rebuild }} --flake .

rollback:
    {{ nix-rebuild }} --flake . --rollback

up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake update $(i)

# garbage collect all unused nix store entries
gc:
  sudo nix-collect-garbage --delete-old