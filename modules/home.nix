{ config, pkgs, ... }:
let
  user = config.myconfig.user;
  homeDirectory = config.home-manager.users.${user.username}.home.homeDirectory;
in
{
  home-manager.users.${user.username} =
    {
      imports = config.myconfig.extraHomeModules;

      home.stateVersion = "25.05";

      home.file.".ben-zsh" = {
        source = ../dotfiles/ben-zsh;
        recursive = true;
      };
      home.file.".bash_profile".source = ../dotfiles/bash_profile;
      home.file.".bashrc".source = ../dotfiles/bashrc;
      home.file.".colors".source = ../dotfiles/colors;
      home.file.".functions".source = ../dotfiles/functions;
      home.file.".profile".source = ../dotfiles/profile;
      home.file.".psqlrc".source = ../dotfiles/psqlrc;
      home.file.".pylintrc".source = ../dotfiles/pylintrc;
      home.file.".ssh-agent".source = ../dotfiles/ssh-agent;
      home.file.".vim" = {
        source = ../dotfiles/vim;
        recursive = true;
      };
      home.file.".vimrc".source = ../dotfiles/vimrc;
      home.file.".xinitrc".source = ../dotfiles/xinitrc;
      home.file."Library/Application Support/Slack/local-settings.json" = {
        # The 'text' attribute will create the file with the specified content.
        text = builtins.toJSON {
          # The value for "PrefSSB" must be a JSON *string*.
          # We achieve this by calling builtins.toJSON a second time.
          PrefSSB = builtins.toJSON { "theme" = "dark"; };
        };
      };
    };
}
