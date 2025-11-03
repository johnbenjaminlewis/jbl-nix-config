{ config, pkgs, ... }:
let
  user = config.myconfig.user;
  localhost = config.myconfig.localhost;
in
{
  environment.systemPackages = with pkgs; [
    coreutils
    git
  ];

  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.hostPlatform = localhost.system;

  system.configurationRevision = config.myconfig.nixRevision;
  system.primaryUser = user.username;
  system.stateVersion = 6;

  users.users.${user.username} = {
    name = user.username;
    home = "/Users/${user.username}";
  };
}
