{ pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
    plugins = [
      pkgs.vimPlugins.nvim-treesitter
    ];
  };
}