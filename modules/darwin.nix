{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
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

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    defaults = {
      # Show a sound control in menu bar
      controlcenter = {
        BatteryShowPercentage = true;
        Sound = true;
      };

      # customize dock
      dock = {
        autohide = false; # automatically hide and show the dock
        show-recents = false; # do not show recent apps in dock
        # do not automatically rearrange spaces based on most recent use.
        mru-spaces = false;
        expose-group-apps = true; # Group windows by application

        # customize Hot Corners
        wvous-tl-corner = 2; # top-left - Mission Control
        wvous-tr-corner = 4; # top-right - Desktop
        wvous-bl-corner = 3; # bottom-left - Application Windows
        wvous-br-corner = 1; # bottom-right - disabled
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      # Customize the system clock display
      menuExtraClock = {
        Show24Hour = true;
        ShowSeconds = true;
      };

      CustomUserPreferences.googlecode.iterm2.plist = {
        "Disable bell" = true;
      };

      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
        "com.apple.trackpad.trackpadCornerClickBehavior" = 1; # Configures the trackpad corner click behavior

        # Appearance
        AppleInterfaceStyle = "Dark";
      };
    };
  };
}
