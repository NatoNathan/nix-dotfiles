{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    kubernetes-helm
    kubectl
    argocd
  ];

  programs.k9s = {
    enable = true;
  };
}