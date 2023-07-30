{ config, pkgs, ... }:

{
  home.username = "piter";
  home.homeDirectory = "/home/piter";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    alacritty tmux neovim
    brave
    git
    git-crypt
    gnupg
    pinentry_qt
    ripgrep
    file

    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
