{ pkgs, ... }: {
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ./programs/zsh
    ./programs/node
  ];

  # Global Packages
  environment.systemPackages = with pkgs; [
    gccgo13
    rustc
    cargo
    unzip
    ripgrep
  ];

  environment.variables.EDITOR = "nvim";

  # Enabling experimental nix-ld feature to allow mason.nvim to work correctly
  nix.settings.experimental-features = "nix-command";
  programs.nix-ld = {
    enable = true;
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "anton-almosov-workstation";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [ ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEatcCgSGZZ/MERQJJftRZuHCe0gK4RGqCXiPFrB+6S'' ];
  system.stateVersion = "23.11";

  # Aliases
  environment.shellAliases = {
    update = "sudo nixos-rebuild switch && zsh";
    snvim = "sudo -E nvim";
  };

  # Allowed ports
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 22 3000 ];
  };

  # Setting up the user
  users.defaultUserShell = pkgs.zsh;
  users.users.anton = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/anton/";
    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEatcCgSGZZ/MERQJJftRZuHCe0gK4RGqCXiPFrB+6S''
      ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxEblv/BA9H0TNRJbSeNlUNbHPWd28RwFmNmOhqy/PLODfQUURvFUSR719stwnTF14RuFFGCPsum0tsIKZDZAA8CYkT+YRfTeza5yNwbGWm6QT+lpsZ6FS3wghNOe9T8Gjd0mnBP1UzhSoMXnY2oL2YrUSVhZ6FEzOWw9+gM9LBjFVMKEverWyzUQ88I/llAwDjJstC8/hZxpzrb/om68cm5BNty3XXQ4Ce3WmqZK/641aiA0PJV8ik1nh4IykPSP6abIW18Tr75+r9XgPg7PtkVjhE8Xnmo/CU+4ISIkzId714fR0Jx2GBaOU0fLIeI4hoxAMRRM1rL/ntsBw2RVJ''
    ];
  };

  # Home Manager Setup
  home-manager.users.anton = { ... }: {
    imports = [
      ./programs
    ];


    programs.git = {
      enable = true;
      userName = "Anton Almosov";
      userEmail = "almosoww@gmail.com";
    };

    home.stateVersion = "23.11";
  };
}
