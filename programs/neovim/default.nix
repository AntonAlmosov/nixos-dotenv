{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };
}
