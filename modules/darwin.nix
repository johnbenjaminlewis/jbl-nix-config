{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "amethyst"
      "docker"
      "firefox"
      "google-drive"
      "iterm2"
      "obsidian"
      "slack"
      "spotify"
      "visual-studio-code"
      "zotero"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    CustomUserPreferences.googlecode.iterm2.plist = {
      "Disable bell" = true;
    };
    NSGlobalDomain."AppleInterfaceStyle" = "Dark";
  };
}
