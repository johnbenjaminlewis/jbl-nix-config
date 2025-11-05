{ config, pkgs, ... }:
let
  user = config.myconfig.user;
  homeDirectory = config.home-manager.users.${user.username}.home.homeDirectory;
in
{
  home-manager.users.${user.username} =
    {
      home.packages = with pkgs; [
        zsh
      ];

      home.file.".functions".source = ../dotfiles/functions;

      programs.zsh = {
        enable = true;
        enableCompletion = true;
        oh-my-zsh = {
          enable = true;
          theme = "ben";
          custom = "${homeDirectory}/.ben-zsh";


          # The oh-my-zsh.plugins option is a list of strings.
          # Home Manager will automatically handle the plugins for you.
          plugins = [
            "docker"
            "docker-compose"
            "docker-machine"
            "gcloud"
            "git"
            "gnu-utils"
            "nmap"
            "pip"
            "pipenv"
            "postgres"
            "python"
            "stack"
            "sudo"
            "terraform"
          ] ++ (
            if pkgs.stdenv.isDarwin then [ "brew" "macos" ]
            else if pkgs.stdenv.isLinux then [ "debian" "dircycle" "systemd" "ubuntu" "ufw" ]
            else [ ]
          );
        };

        setOptions = [
          "EXTENDED_HISTORY"
          "HIST_EXPIRE_DUPS_FIRST"
          "HIST_FIND_NO_DUPS"
          "HIST_IGNORE_ALL_DUPS"
          "HIST_IGNORE_DUPS"
          "HIST_IGNORE_SPACE"
          "HIST_REDUCE_BLANKS"
          "HIST_SAVE_NO_DUPS"
          "HIST_VERIFY"
          "INC_APPEND_HISTORY"
          "SHARE_HISTORY"
        ];

        # For `~/.functions`, you could place its content inside initExtra or create
        # a separate file and symlink it.
        #home.file.".ben-zsh".source = ./ben-zsh; # Assuming this is a custom directory for your theme

        initContent = ''
          bindkey \^U backward-kill-line
          bindkey \^B backward-word
          bindkey \^F forward-word

          # Your custom functions
          source ${homeDirectory}/.functions

          # Fzf config
          [ -f ${homeDirectory}/.fzf.zsh ] && source ${homeDirectory}/.fzf.zsh

          # User configuration
          source ${homeDirectory}/.profile
        '';
      };
    };
}
