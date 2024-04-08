{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ nodejs_18 nodePackages.pnpm nodePackages.yarn ];
}
