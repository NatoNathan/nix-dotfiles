default: install-hooks deploy

os := `uname -s`
# the nix rebuild command for the system i.e. nixos (nixos-rebuild), darwin (darwin-rebuild)
nix-rebuild :=  if os == "Darwin" {
    "darwin-rebuild switch"
} else if `grep -q 'ID=nixos' /etc/os-release && echo "nixos" || echo "not-nixos"` == "nixos" {
    "nixos-rebuild switch --use-remote-sudo"
} else {
    error("OS is not supported")
}

# Deploy the system configuration
deploy:
    @echo "Deploying system configuration"
    {{ nix-rebuild }} --flake .

rollback:
    {{ nix-rebuild }} --flake . --rollback
    git reset HEAD~1

up:
  nix flake update
  git add flake.lock
  git commit -m "Update flake inputs"
  git push

# Update specific input
# usage: make upp i=home-manager
upp INPUT:
  nix flake update {{ INPUT }}
  git add flake.lock
  git commit -m "Update flake input {{ INPUT }}"
  git push

# garbage collect all unused nix store entries
gc:
  sudo nix-collect-garbage --delete-old

# Install hooks
install-hooks:
  git config --local core.hooksPath .githooks