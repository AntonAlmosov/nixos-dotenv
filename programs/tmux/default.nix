{ pkgs, ... }: {

  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
  };

  home.file.".tmux.conf" = {
    source = ./.tmux.conf;
  };
}
