{ config, pkgs, user, ... }: 

{
  home.username = user;
  home.homeDirectory = "/home/" + config.home.username;
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = [
    (pkgs.writeShellScriptBin "flux-bar"          (builtins.readFile ../scripts/flux-bar.sh) )
    (pkgs.writeShellScriptBin "flux-powerOptions" (builtins.readFile ../scripts/flux-powerOptions.sh) )
    (pkgs.writeShellScriptBin "flux-lock"         (builtins.readFile ../scripts/flux-lock.sh) )
  ];

  home.file = {
    ".zshrc".source = ../scripts/.zshrc;
  };

  programs.home-manager.enable = true;
}
