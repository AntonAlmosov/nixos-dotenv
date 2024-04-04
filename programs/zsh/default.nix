{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "tmux" ];
      customPkgs = [
        pkgs.nix-zsh-completions
      ];
    };

    shellInit = ''
      export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent
      export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
      eval `ssh-agent`
    '';
  };
}
