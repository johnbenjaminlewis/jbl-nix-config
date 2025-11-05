{ config, pkgs, ... }:
{
  homebrew.casks = ["iterm2"];

  system = {
    defaults = {
      CustomUserPreferences.googlecode.iterm2.plist = {
        "Disable bell" = true;
      };
    };
  };
}
