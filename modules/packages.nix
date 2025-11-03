# ./common/packages.nix
{ pkgs, config, ... }:
let
  python-alias = pkgs.linkFarm "python-alias" [
    {
      name = "python";
      path = "${pkgs.python3}/bin/python3";
    }
  ];
in
{
  home-manager.users.${config.myconfig.user.username}.home.packages = with pkgs; [
    coreutils
    curl
    findutils
    fzf
    gawk
    gh
    git
    gnugrep
    gnused
    iftop
    iperf
    jq
    less
    neovim
    python-alias
    silver-searcher
    tmux
    (vim_configurable.override {
      python3 = pkgs.python3;
    })
    wget
    zsh
  ];
}
